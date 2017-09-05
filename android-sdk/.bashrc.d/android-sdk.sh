# Initialize ANDROID_HOME and PATH for Android SDK installed with Ubuntu Make.
# (This is kinda hacky, for now.)
#
if [[ -z "$ANDROID_HOME" && -d "$HOME/.local/share/umake/android/android-sdk" ]]; then
    export ANDROID_HOME="$HOME/.local/share/umake/android/android-sdk"
    PATH="$PATH:$ANDROID_HOME/platform-tools"
    PATH="$PATH:$ANDROID_HOME/tools"
    PATH="$PATH:$ANDROID_HOME/tools/bin"
fi
