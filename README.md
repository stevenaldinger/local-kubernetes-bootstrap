# Getting Started with Kubernetes on Mac

This guide will reference some helper functions that are available in [getting_started.sh](getting_started.sh).

Sourcing the `getting_started.sh` file will make these functions available in your terminal.

`. getting_started.sh`

I do my best to `echo` comments as the scripts run and any actual commands I try to echo with `$-:` preceding to signal that its actually being run as a command, such as `$-: brew up` to tell you `brew up` is actually about to be run.

With all of that said, I highly recommend you review these scripts and any others you run into to learn what's going on and ensure nothing mischievous is sneaking by.

## Install Docker for Mac (or whatever operating system you're using)

`install_docker_for_mac`

Follow the graphic that pops up and drag the `Docker` icon, [Moby Dock](https://blog.docker.com/2013/10/call-me-moby-dock/), into your `Applications` folder.

In your Mac's dock (bar at the bottom) click on `Applications` in and then on `Docker` to start it up. It'll need you to give your password the first time it launches because it needs to run privileged.

## Install Minikube (Run Kubernetes locally)

To give [Kubernetes](https://kubernetes.io/) a try without using a hosted option through a Cloud provider (I recommend [Google Container Engine](https://cloud.google.com/container-engine/) if you take the hosted route), [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) is a fantastic option to easily run a local cluster on your machine.

**NOTE:** [VT-x or AMD-v virtualization must be enabled in your computer’s BIOS.](https://kubernetes.io/docs/tasks/tools/install-minikube/) which you can check by running `check_virtualization_enabled` if you have sourced the helpers.

You'll also need a hypervisor installed. I've used both [VirtualBox](https://www.virtualbox.org/) and `xhyve` previously but found `VirtualBox` [performed much better](https://thepracticalsysadmin.com/xhyve-vs-vbox-driver-benchmarks-for-docker-machine/). Although this reference is over a year old at the time of writing and I did not run any tests myself, I did find `xhyve` seemed to perform much slower for me.

### Install VirtualBox for Mac

`install_virtualbox_for_mac`

Follow the instructions in the popup graphic to finish installation.

### Install kubectl utility

`install_kubectl_for_mac`

### Install Minikube

`install_minikube`

#### Configure and start Minikube!

Although not required, I encourage you to configure Minikube before you get started because configuration changes won't take effect until deleting the cluster and restarting it otherwise, which will destroy any work you have saved in the cluster.

[**Bug report!**](https://github.com/kubernetes/minikube/issues/1622) If you have trouble accessing `KubeDNS` or the `kube-dashboard` after starting minikube you may need to run `VBoxManage modifyvm "minikube" --natdnshostresolver1 on`!

Alter the commands below to suit your needs.

`minikube config set vm-driver virtualbox`

`minikube config set cpus 2`

`minikube config set memory 4192`

`minikube start`

To check out your new cluster: `kubectl cluster-info`

## Install Brew Package Manager (optional)

This isn't required but `brew` will be referenced in tutorials in the future as an easy way to manage packages. The biggest advantage gained from using `brew` (in my opinion) is that its as easy to uninstall and update packages as it is to install them, and I do my best to keep my local machine a clean slate. The biggest disadvantage is that the packages are rarely as up-to-date as downloading the most recent version of something "manually".

`install_and_update_brew`

You'll need to press `return` once to continue the install and type your password once to allow it to create the directories it'll be installing programs into in the future.

# Uninstalling

## Docker

1. Open up your `Applications` folder
2. Drag the `Docker` icon into the `Trash` trashcan icon
3. Right click the trashcan icon
4. Click `Empty Trash`

## Minikube and kubectl

Both minikube and kubectl are just binaries that we placed in `/usr/local/bin/`, but both create configuration directories in `$HOME`. Uninstalling is as easy as removing those executables, although to "clean" uninstall you'll also need to remove `$HOME/.minikube/` and `$HOME/.kube/`.

### minikube

`uninstall_minikube`

### kubectl

`uninstall_kubectl`

## Homebrew

**WARNING!!** This will uninstall _all_ brew installed programs, and then brew itself! Run with caution!

`uninstall_brew`

You'll have to confirm with `y` for yes as well as input your password before it wipes the relevant files and directories.
