#! /usr/bin/env bash
#  myhelp.sh
#  Author: Roman Briggs 2026

#Config
helpdir="${HOME}/.help"

# Init
if [[ ! -d "$helpdir" ]]; then
  mkdir "$helpdir" || { echo "Directory $helpdir does not exist and cannot be created!" && exit 1; }
fi

get_helpfiles () {
    find "$helpdir" -maxdepth 1 -mindepth 1 ! -name ".*" -printf "  %f\n"
exit 0; }

do_usage () {
	echo "Usage:"
	echo "  myhelp    <helpfile>"
	echo "  myhelp -n <helpfile>"
	echo "  myhelp -e <helpfile>"
	echo ""
	echo "Options:"
	echo "  -n|--new  : create new helpfile"
	echo "  -e|--edit : edit existing helpfile"
	echo "  -l|--list : list existing helpfiles"
	echo "  -h|--help : this help message"
	echo ""
    echo "Available helpfile entries:"
    get_helpfiles
}

new_helpfile () {
    local confirm="${confirm:-false}"
    if [ "$confirm" = true ]; then
      r=''
      read -r -p "$1 has no help file. Create one? [Y/n] > " r
      case "$r" in
        y|Y|"${NULL}")
        ;;
        *)
          echo "kthxbai" && exit 1
        ;;
      esac
    fi
    touch "$helpdir/$1" || ( echo "Cannot write $helpdir/$1!" && exit 255 )
    sleep 0.1
    nano "$helpdir/$1"
exit 0; }

# Check if we were called without an option nor a file
[[ -n "$1" ]] || do_usage

# Check if we have a valid option
case "$1" in
    -h|--help)
      do_usage
    ;;
    -l|--list)
      get_helpfiles
    ;;
    -n|--new)
      if   [[ -f "$helpdir/$2" ]]
      then echo  "Help file $helpdir/$2 exists!" && exit 1
      else new_helpfile "$2"
      fi
    ;;
    -e|--edit)
      if   [[ -f "$helpdir/$2" ]]
      then nano  "$helpdir/$2" || exit 0
      else confirm=true new_helpfile
      fi
    ;;
    # Option, but not valid: error
    -*)
      echo "Unrecognized option!" && exit 1
    ;;
    *)
    # No option: fall through
    ;;
esac

# Check if we are referencing an existing file, or offer to create one
[[ -f "$helpdir/$1" ]] || confirm=true new_helpfile "$1"
nano "$helpdir/$1"

exit 0
