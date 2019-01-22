#!/usr/bin/env bash
set -e

echo "[i] Ask for sudo password"
sudo -v

echo -n "Path to ASCII-armored GPG keys to import: "
read -r KEYS

echo -n "Password store git host: "
read -r PASSWORD_STORE_HOST

case "$(uname -s)" in
  Darwin)
    playbook="macos.yml"
    # install Command Line Tools
    if [[ ! -x /usr/bin/gcc ]]; then
      echo "[i] Install macOS Command Line Tools"
      xcode-select --install
    fi

    if [[ ! -x /usr/local/bin/brew ]]; then
      echo "[i] Install Homebrew"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if [[ ! -x /usr/local/bin/gpg ]]; then
      echo "[i] Install gpg2"
      brew install gpg2
    fi

    if [[ "$KEYS" != "" ]]; then
      echo "[i] Importing GPG keys"
      find "$KEYS" -type f -name "*.asc" -exec gpg --import {} \;
    fi

    if [[ ! -x /usr/local/bin/pass ]]; then
      echo "[i] Install pass"
      brew install pass
    fi

    if [[ ! -d ~/.password-store ]]; then
      echo "[i] Initialize passwords"
      git clone "bb@$PASSWORD_STORE_HOST:git/password-store.git" ~/.password-store
    fi

    if [[ ! -x /usr/local/bin/ansible ]]; then
        echo "[i] Install Ansible"
        brew install ansible
    fi
    ;;
  Linux)
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      if [[ "$ID_LIKE" == "debian" || "$ID" == "debian" ]]; then
        playbook="debian.yml"

        if [[ ! -x /usr/bin/gpg ]]; then
          echo "[i] Install gpg"
          sudo apt-get install gpg2
        fi

        if [[ "$KEYS" != "" ]]; then
          echo "[i] Importing GPG keys"
          find "$KEYS" -type f -name "*.asc" -exec gpg --import {} \;
        fi

        if [[ ! -x /usr/bin/pass ]]; then
          echo "[i] Install pass"
          sudo apt-get install -y pass
        fi

        if [[ ! -d ~/.password-store ]]; then
          echo "[i] Initialize passwords"
          git clone "bb@$PASSWORD_STORE_HOST:git/password-store.git" ~/.password-store
        fi

        # install ansible
        if [[ ! -x /usr/bin/ansible ]]; then
          echo "[i] Add Ansible apt repository"
          echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/ansible.list
          sudo apt-get install -y dirmngr
          sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

          echo "[i] Install Ansible"
          sudo apt-get update
          sudo apt-get install -y ansible
        fi
      else
        echo "[!] Unsupported Linux Distribution: $ID"
        exit 1
      fi
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

# Run main playbook
echo "[i] Run Playbook"
if [ -z "$playbook" ]; then
  echo "[!] No playbook discovered to run, are you on a supported OS?"
  exit 1
fi
ansible-playbook "$playbook" --ask-become-pass

echo "[i] Done."
