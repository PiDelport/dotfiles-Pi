# Miscellaneous Django-related helpers.

# Configure a virtualenv to have DJANGO_SETTINGS_MODULE set.
___django_set_settings_module () {
    : ${VIRTUAL_ENV:?'$VIRTUAL_ENV not set!'}
    local settings_module="${1:-'dev_settings'}"
    echo "Configuring DJANGO_SETTINGS_MODULE='$settings_module' in $VIRTUAL_ENV"
    echo "export DJANGO_SETTINGS_MODULE='$settings_module'" >>"$VIRTUAL_ENV"/bin/postactivate
    echo 'unset DJANGO_SETTINGS_MODULE' >>"$VIRTUAL_ENV"/bin/postdeactivate
    export DJANGO_SETTINGS_MODULE="$settings_module"
}

# Create a stock superuser account.
___django_add_superuser () {
    django-admin.py createsuperuser --noinput --email pi@example.com pi
    django-admin.py changepassword pi@example.com
}

# Install various sets of system package dependencies.
___install_python_deps () { sudo aptitude install python-dev python3-dev; }
___install_lxml_deps () { sudo aptitude install libz-dev libxml2-dev libxslt-dev; }
___install_pillow_deps () { sudo aptitude install zlib1g-dev libjpeg-dev libwebp-dev liblcms2-dev libfreetype6-dev; }
___install_postgresql_deps () { sudo aptitude install libpq-dev; }
___install_geodjango_deps () { sudo aptitude install libgeos-dev libgeos++-dev libproj-dev libgdal-dev; }
___install_spatialite_deps () { ___install_geodjango_deps; sudo aptitude install sqlite3 spatialite-bin libsqlite3-mod-spatialite; }

# Prepare a Spatialite database for use.
___init_spatialite_db () {
    spatialite ${1:?"Usage: ___init_spatialite_db <database>"} 'SELECT InitSpatialMetaData();'
}


# Show a diff between the Django migration states of two Mercurial checkouts.
#
# Use this on a clean checkout!
#
# The optional third argument overrides the diff command to invoke.
# Examples: 'diff -u', vimdiff, meld
#
___django_migrations_diff () {
    local usage="Usage: ___django_migrations_diff REV1 REV2 [diff command]"
    local rev1="${1:?"$usage"}"
    local rev2="${2:?"$usage"}"
    local diff_command="${3:-'diff -u'}"
    $diff_command <( hg up -q "$rev1" && django-admin showmigrations) <( hg up -q "$rev2" && django-admin showmigrations)
}
