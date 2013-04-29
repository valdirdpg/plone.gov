#!/bin/sh

# Ensure that SSH_AUTH_SOCK is kept
if [ -n "$SSH_AUTH_SOCK" ]; then
  echo "SSH_AUTH_SOCK is present"
else
  echo "SSH_AUTH_SOCK is not present, adding as env_keep to /etc/sudoers"
  echo "Defaults env_keep+=\"SSH_AUTH_SOCK\"" >> "/etc/sudoers"
fi
