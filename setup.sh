#!/usr/bin/env bash
set -e

echo "[i] Ask for sudo password"
sudo -v

case "$(uname -s)" in
  Darwin)
    playbook="macos.yml"
    # install Command Line Tools
    if [[ ! -x /usr/bin/gcc ]]; then
      echo "[i] Install macOS Command Line Tools"
      xcode-select --install
    fi

    # install homwbrew
    if [[ ! -x /usr/local/bin/brew ]]; then
      echo "[i] Install Homebrew"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # install ansible
    if [[ ! -x /usr/local/bin/ansible ]]; then
        echo "[i] Install Ansible"
        brew install ansible
    fi
    ;;
  Linux)
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      case "$ID_LIKE" in
        debian)
          if [[ ! -x /usr/bin/ansible ]]; then
            echo "[i] Install Ansible"
            sudo apt-get install -y ansible
          fi
          ;;
        *)
          echo "[!] Unsupported Linux Distribution: $ID"
          exit 1
          ;;
      esac
    else
      echo "[!] Unsupported Linux Distribution"
      exit 1
    fi
    ;;
  *)
    echo "[!] Unsupported OS"
    exit 1
    ;;
esac

if [ -f "$HOME/.bashrc" ] && [ ! -h "$HOME/.bashrc" ]; then
  echo "[i] Move current ~/.bashrc to ~/bashrc_backup"
  mv "$HOME/.bashrc" "$HOME/bashrc_backup"
fi

if [ -f "$HOME/.bash_profile" ] && [ ! -h "$HOME/.bash_profile" ]; then
  echo "[i] Move current ~/.bash_profile to ~/bash_profile_backup"
  mv "$HOME/.bash_profile" "$HOME/bash_profile_backup"
fi

# Run main playbook
echo "[i] Run Playbook"
if [ -z "$playbook" ]; then
  echo "[!] No playbook discovered to run, are you on a supported OS?"
  exit 1
fi
ansible-playbook "$playbook" --ask-become-pass

echo "[i] Done."
