# Miscellaneous Django-related helpers.

# Configure a virtualenv to have DJANGO_SETTINGS_MODULE set.
___django_set_settings_module () {
    : ${VIRTUAL_ENV:?'$VIRTUAL_ENV not set!'}
    echo "Configuring DJANGO_SETTINGS_MODULE=settings in $VIRTUAL_ENV"
    echo 'export DJANGO_SETTINGS_MODULE=settings' >>"$VIRTUAL_ENV"/bin/postactivate
    echo 'unset DJANGO_SETTINGS_MODULE' >>"$VIRTUAL_ENV"/bin/postdeactivate
    export DJANGO_SETTINGS_MODULE=settings
}

# Create a stock superuser account.
___django_add_superuser () {
    django-admin.py createsuperuser --noinput --email piet@example.com piet
    django-admin.py changepassword piet@example.com
}

# Install various sets of system package dependencies.
___install_python_deps () {
    sudo aptitude install python-dev python3-dev
}
___install_pillow_deps () {
    sudo aptitude install zlib1g-dev libjpeg-dev libwebp-dev liblcms2-dev libfreetype6-dev
}
___install_geodjango_deps () {
    sudo aptitude install libgeos-dev libgeos++-dev libproj-dev libgdal-dev
}
___install_spatialite_deps () {
    ___install_geodjango_deps
    sudo aptitude install sqlite3 spatialite-bin
}

# Prepare a Spatialite database for use.
___init_spatialite_db () {
    spatialite ${1:?"Usage: ___init_spatialite_db <database>"} 'SELECT InitSpatialMetaData();'
}
