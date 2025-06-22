#!/usr/bin/env bash

# Author: Brian Spragge
# License: MIT, but you also must show me cool stuff you add.
# Special Thanks: S0AndS0 for the inspiration to learn Bash.


# Program: GPG_CRD - Create, Revoke, Delete for GPG keys(My first bash program)

are_keys() {
  local -n _keys="$1"
  if [ ${#_keys[@]} -eq 0 ]; then
    echo 'No secret keys found.'
    return 1
  fi
}

list_keys() {
  readarray -t keys < <(
    gpg --list-secret-keys --keyid-format=long --with-colons |
    awk -F: '/^sec:/ { key=$5; next } /^uid:/ && key { print key " - " $10 }'
  )
  are_keys keys
}

# TODO: Fix PUBLIC KEY BLOCK: not copyable.
create_key() {
  gpg --full-generate-key
  list_keys
  echo 'Select newly created GPG key for exporting:'
  select key in "${keys[@]}"; do
    if [[ -n "$key" ]]; then
      local key_id="${key%% *}"
      clear
      cat <<EOF
You chose: $key
Copy and paste into GitHub:

EOF
      gpg --armor --export "$key_id"
      break
    else
      echo 'Nope, not even close.'
    fi
  done
}

# TODO: Clear screen after deleting key before prints new menu state:
#         shows four lines of deletion above "Choose GPG key: " menu.
key_actions() {
  local key="$1"
  local key_id="${key%% *}"
  while true; do
    echo "You chose: $key"
    select action in 'Revoke key' 'Delete key' 'Main Menu'; do
      case "$REPLY" in
        1)
          read -p 'Are you sure you wish to revoke? (y/N): ' confirm
          if [[ "$confirm" =~ ^[Yy]$ ]]; then
            clear
            gpg --output revoke.asc --gen-revoke "$key_id"
            gpg --import revoke.asc
            gpg --send-keys "$key_id"
            printf "\n%s" 'Key revoked.'
            return 0
          else
            echo 'Cancelled.'
          fi
          ;;
        2)
          read -p 'Are you sure you wish to delete? (y/N): ' confirm
          if [[ "$confirm" =~ ^[Yy]$ ]]; then
            clear
            gpg --delete-secret-keys "$key_id"
            gpg --delete-keys "$key_id"
            printf "\n%s" 'Key deleted.'
            return 0
          else
            echo 'Cancelled.'
          fi
          ;;
        3)
          printf "\n%s" 'Returning to Main Menu'
          return 0
          ;;
        *)
          printf "\n%s\n" 'Nope, not even close.'
          read -srn1 -p 'Press any key to continue...'
          ;;
        esac
        clear
        break
      done
    done
}


while true; do
  clear
  list_keys
  # Menu
  printf "%s\n\n" 'Choose GPG key:'
  select key in "${keys[@]}" 'Create key' 'Exit'; do
    if [[ "$REPLY" -gt 0 && "$REPLY" -le "${#keys[@]}" ]]; then
      selected_key="${keys[$REPLY-1]}"
      clear
      key_actions "$selected_key"
      break
    elif [[ "$REPLY" == $((${#keys[@]}+1)) ]]; then  # CREATE
      clear
      create_key
      break
    elif [[ "$REPLY" == $((${#keys[@]}+2)) ]]; then  # EXIT
      clear
      printf "\n%s" 'Smell ya later!'
      sleep 1
      clear
      exit 0
    else
      printf "\n%s" 'Nope, not even close.'
      break
    fi
  done
  echo
  read -srn1 -p 'Press any key to continue...'
done


# TODO: I believe there are unnecessary global vars,
#       which should be passed and returned locally instead.

