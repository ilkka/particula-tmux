#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $current_dir/utils.sh

vpn_function() {
  case $(uname -s) in
  Linux)
    if ip route | grep -q "^default"; then
      if ip route | grep -q "^default dev tun0"; then
        if pgrep vpnc &>/dev/null; then
          echo "😀 VPN"
        else
          echo "😓 vpnc"
        fi
      else
        echo ""
      fi
    else
      echo "😓 routes"
    fi
  ;;
  
  Darwin)
    vpn=$(scutil --nc list | grep Connected)

    if [ -z $vpn ]; then
      echo ""
    else
      echo "VPN"
    fi
    ;;

  CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # TODO - windows compatability
    ;;
  esac
}

main() {

  echo $(vpn_function)
}

# run main driver
main
