[HippUnfold Documentation](../index.html)

Getting started

* [Installation](installation.html)
* [Running HippUnfold with Docker on Windows](docker.html)
* [Running HippUnfold with Singularity](singularity.html)
* Running HippUnfold with a Vagrant VM
  + [Install VirtualBox and Vagrant](#install-virtualbox-and-vagrant)
  + [Create a Vagrant Box](#create-a-vagrant-box)
  + [Download the test dataset](#download-the-test-dataset)
  + [Download the HippUnfold container](#download-the-hippunfold-container)
  + [Run HippUnfold](#run-hippunfold)

Usage Notes

* [Command-line interface](../usage/cli.html)
* [Running HippUnfold on your data](../usage/useful_options.html)
* [Specialized scans](../usage/specializedScans.html)
* [Template-base segmentation](../usage/templates.html)
* [Frequently asked questions](../usage/faq.html)

Processing pipeline details

* [Pipeline Details](../pipeline/pipeline.html)
* [Algorithmic details](../pipeline/algorithms.html)

Outputs of HippUnfold

* [Output Files](../outputs/output_files.html)
* [Visualization](../outputs/visualization.html)
* [Quality Control](../outputs/QC.html)

Contributing

* [References](../contributing/references.html)
* [Contributing to Hippunfold](../contributing/contributing.html)

[HippUnfold Documentation](../index.html)

* Running HippUnfold with a Vagrant VM
* [View page source](../_sources/getting_started/vagrant.md.txt)

---

# Running HippUnfold with a Vagrant VM[](#running-hippunfold-with-a-vagrant-vm "Permalink to this heading")

This option uses Vagrant to create a virtual machine that has Linux
and Singularity installed. This allows you to use Singularity to run HippUnfold
from a clean environment, whether you are running Linux, Mac or Windows (since all
three are supported by Vagrant). Note: VirtualBox does the actual
virtualization in this example, but Vagrant provides an easy and reproducible way to create and
connect to the VMs (as shown below).

## Install VirtualBox and Vagrant[](#install-virtualbox-and-vagrant "Permalink to this heading")

The example below uses Vagrant and VirtualBox installed on Ubuntu 20.04.

The [Vagrant install instructions](https://developer.hashicorp.com/vagrant/downloads) describe
what you need to do to install on Mac, Windows or Linux.

Vagrant must use a **provider** for the actual virtualization. The instructions here assume you
are using VirtualBox for this, since it is free and easy to use, but in principle should work with any
virtualization provider. The [VirtualBox downloads page](https://www.virtualbox.org/wiki/Downloads)
can guide you through the process of installing it on your system (Mac, Windows, Linux supported).

## Create a Vagrant Box[](#create-a-vagrant-box "Permalink to this heading")

Once you have Vagrant and VirtualBox installed, the following screencast demonstrates
how you can setup a Box with Singularity pre-loaded on it. The main steps are to 1) create a Vagrantfile, 2) start the box using `vagrant up`, and 3) connect to it using `vagrant ssh`.

Note: These screencasts are more than just videos, they are asciinema recordings – you can pause them and then copy-paste text
directly from the asciinema cast!

This is the `Vagrantfile` used in the video, for quick reference:

```
Vagrant.configure("2") do |config|
  config.vm.box = "sylabs/singularity-3.7-ubuntu-bionic64"
  config.vm.provider "virtualbox" do |vb|
     vb.cpus = 8
     vb.memory = "8096"
   end
end
```

## Download the test dataset[](#download-the-test-dataset "Permalink to this heading")

We are downloading the test dataset with the following
command:

```
wget https://www.dropbox.com/s/mdbmpmmq6fi8sk0/hippunfold_test_data.tar
```

## Download the HippUnfold container[](#download-the-hippunfold-container "Permalink to this heading")

We pull/build the container from DockerHub:

```
singularity pull docker://khanlab/hippunfold:latest
```

## Run HippUnfold[](#run-hippunfold "Permalink to this heading")

This demonstrates the basic HippUnfold options, and how
to perform a dry-run:

Finally, we can run HippUnfold using all the cores:

[Previous](singularity.html "Running HippUnfold with Singularity")
[Next](../usage/cli.html "Command-line interface")

---

© Copyright 2020, Jordan DeKraker and Ali R. Khan.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).