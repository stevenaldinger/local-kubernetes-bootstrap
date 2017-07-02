#!/bin/bash

# ------------------------ Homebrew Package Manager ---------------------------#
install_and_update_brew () {
  if test ! $(which brew); then
    echo 'Installing homebrew...'
    echo '$-: ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo 'Homebrew is already  installed.'
  fi

  # Make sure we’re using the latest Homebrew.
  echo '$-: brew update'
  brew update

  # Upgrade any already-installed formulae.
  echo 'Upgrading any installed brew packages.'
  echo '$-: brew up'
  brew up

  echo 'Removing any outdated versions from brew'"'"'s cellar.'
  echo '$-: brew cleanup'
  brew cleanup
}

uninstall_brew () {
  echo 'Removing all brew installed programs.'
  echo '$-: brew list -1 | xargs brew rm'
  brew list -1 | xargs brew rm

  echo 'Downloading Homebrew uninstall script and running it.'
  echo '$-: /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}
# ----------------------- End Homebrew Package Manager ------------------------#

# ------------------------ Docker Container Platform --------------------------#
install_docker_for_mac () {
  echo 'Downloading Docker.dmg for Mac.'
  echo '$-: curl -Lo /tmp/Docker.dmg https://download.docker.com/mac/stable/Docker.dmg'
  curl -Lo /tmp/Docker.dmg https://download.docker.com/mac/stable/Docker.dmg && \
  echo '$-: open /tmp/Docker.dmg' && \
  open /tmp/Docker.dmg
}
# ---------------------- End Docker Container Platform ------------------------#

# ------------------------ Minikube Kubernetes Cluster ------------------------#
check_virtualization_enabled () {
  echo 'Checking virtualization is enabled.'
  echo '$-: virtualization_enabled=$(sysctl -a | grep machdep.cpu.features | grep VMX)'
  virtualization_enabled=$(sysctl -a | grep machdep.cpu.features | grep VMX)

  echo 'Checking "virtualization_enabled" variable is not empty.'
  if [ -z "${virtualization_enabled}" ]; then
    echo "Minikube requires VT-x/AMD-v virtualization to be enabled in BIOS."
    exit 1
  else
    echo "VT-x/AMD-v virtualization is enabled in BIOS!"
  fi
}

install_virtualbox_for_mac () {
  echo 'Downloading VirtualBox.dmg for Mac.'
  echo '$-: curl -Lo /tmp/VirtualBox.dmg http://download.virtualbox.org/virtualbox/5.1.22/VirtualBox-5.1.22-115126-OSX.dmg'
  curl -Lo /tmp/VirtualBox.dmg http://download.virtualbox.org/virtualbox/5.1.22/VirtualBox-5.1.22-115126-OSX.dmg && \
  echo '$-: open /tmp/VirtualBox.dmg' && \
  open /tmp/VirtualBox.dmg
}

install_kubectl_for_mac () {
  echo 'Downloading and installing kubectl for Mac.'
  echo '$-: curl -Lo /tmp/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"'
  curl -Lo /tmp/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl" && \
  echo '$-: chmod +x /tmp/kubectl' && \
  chmod +x /tmp/kubectl && \
  echo '$-: sudo mv /tmp/kubectl /usr/local/bin/kubectl' && \
  sudo mv /tmp/kubectl /usr/local/bin/kubectl
}

uninstall_kubectl () {
  echo 'Uninstalling kubectl.'
  echo '$-: rm -rf /usr/local/bin/kubectl ~/.kube/'
  rm -rf /usr/local/bin/kubectl ~/.kube/
}

install_minikube () {
  echo 'Downloading and installing Minikube.'
  echo '$-: curl -Lo /tmp/minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-darwin-amd64'
  curl -Lo /tmp/minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-darwin-amd64 && \
  echo '$-: chmod +x /tmp/minikube' && \
  chmod +x /tmp/minikube && \
  echo '$-: sudo mv /tmp/minikube /usr/local/bin/minikube' && \
  sudo mv /tmp/minikube /usr/local/bin/minikube
}

uninstall_minikube () {
  echo 'Uninstalling minikube.'
  echo '$-: rm -rf /usr/local/bin/minikube ~/.minikube/'
  rm -rf /usr/local/bin/minikube ~/.minikube/
}
# ---------------------- End Minikube Kubernetes Cluster ----------------------#
