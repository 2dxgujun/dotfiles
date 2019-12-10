adb__restart() {
  # Default values of arguments
  CLEAR_APP_DATA=0
  PACKAGE_NAME=""
  OTHER_ARGUMENTS=()

  # Loop through arguments and process them
  for arg in "$@"
  do
      case $arg in
          -c|--clear-app-data)
          CLEAR_APP_DATA=1
          shift # Remove --clear-app-data from processing
          ;;
          -*|--*)
          shift
          ;;
          *)
          if [[ -z "$PACKAGE_NAME" ]]; then
            PACKAGE_NAME="$1"
          else
            OTHER_ARGUMENTS+=("$1")
          fi
          shift # Remove generic argument from processing
          ;;
      esac
  done

  OPTIONS_SPEC="\
Usage:
  adb restart [-c|--clear-app-data] PACKAGE
"
  if [[ -z "$PACKAGE_NAME" ]]; then
    echo $OPTIONS_SPEC
    return 1
  fi

  if [[ $CLEAR_APP_DATA -eq 1  ]]; then
    adb shell pm clear $PACKAGE_NAME >/dev/null
  fi
  adb shell am force-stop $PACKAGE_NAME >/dev/null
  adb shell monkey -p $PACKAGE_NAME 1 >/dev/null

  #echo "# Clear app data: $CLEAR_APP_DATA"
  #echo "# Package name: $PACKAGE_NAME"
  #echo "# Other arguments: ${OTHER_ARGUMENTS[*]}"
}

adb() {
  local cmdname=$1; shift
  if type "adb__$cmdname" >/dev/null 2>&1; then
    "adb__$cmdname" "$@"
  else
    command adb "$cmdname" "$@" # call the **real** adb command
  fi
}

# if the functions above are sourced into an interactive interpreter, the user can
# just call "yum download" or "yum maintenance" with no further code needed.

# if invoked as a script rather than sourced, call function named on argv via the below;
# note that this must be the first operation other than a function definition
# for $_ to successfully distinguish between sourcing and invocation:
[[ $_ != $0 ]] && return

# make sure we actually *did* get passed a valid function name
if declare -f "$1" >/dev/null 2>&1; then
  # invoke that function, passing arguments through
  "$@" # same as "$1" "$2" "$3" ... for full argument list
else
  echo "Function $1 not recognized" >&2
  exit 1
fi

