#!/usr/bin/env bash

###########
# Colors  #
###########
COLOR_YELLOW=$(tput setaf 3)
COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
COLOR_LIGHT_BLUE=$(tput setaf 6)
COLOR_NONE=$(tput sgr0)
COLORALERT=$COLOR_LIGHT_BLUE

colorgreen()
{
    echo  -en $COLOR_GREEN"$1"$COLOR_NONE
}

coloryellow()
{
    echo  -en $COLOR_YELLOW"$1"$COLOR_NONE
}

colorred()
{
    echo  -en $COLOR_RED"$1"$COLOR_NONE
}

coloralert()
{
    echo  -en $COLORALERT"$1"$COLOR_NONE
}

#func_usage()
#{
#    echo "[U] Usage: $(coloryellow "${FUNCNAME[1]}"): $(colorred "$1")"
#	export UTIL_FUNC_USAGE_PERROR_MISSING_PARAM="y"
#}
#
#ask_user()
#{
#    msg=$1
#    default_result=$2
#    if [ -z "$msg" ] ; then
#        func_usage "Missing message to tell user"
#				return 1
#    fi
#
#    if [ "$default_result" = "force" ] ; then
#        ask_force "$msg" ; ret=$? ; return $ret
#    else
#        ans=""
#        while [ -z "$ans" ] ; do
#            echo  -ne $COLORALERT"$msg: "$COLOR_NONE
#            if [[ $default_result =~ [yY][eE][sS]|[yY] ]] ; then read -p"[Yes/no] " ans ; fi
#            if [[ $default_result =~ [nN][oO]|[nN] ]] ; then     read -p"[yes/No] " ans ; fi
#            case $ans in
#                [yY][eE][sS]|[yY])
#                  ans="y"
#                  ;;
#                [nN][oO]|[nN])
#                  ans="n"
#                  ;;
#                *)
#                    if [[ $default_result =~ [yY][eE][sS]|[yY] ]] ; then ans="y" ; fi
#                    if [[ $default_result =~ [nN][oO]|[nN] ]] ;     then ans="n" ; fi
#                  ;;
#            esac
#        done
#        [ "$ans" = "y" ] && return 0
#        [ "$ans" = "n" ] && return 1
#    fi
#	return 1
#}
