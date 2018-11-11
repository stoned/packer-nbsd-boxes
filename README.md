# packer-nbsd-boxes

Packer-nbsd-boxes helps to build NetBSD [Vagrant](http://vagrantup.com)
boxes with the help of templates for [Packer](http://packer.io).

It is inspired by Opscode's [Bento](http://opscode.github.io/bento/).

At this time the provided Packer templates only support virtualbox,
both as a builder and as a post-processor provider.

## How to build the boxes

Install [Packer](http://packer.io) then from the top-level of this
project, validate and build a Packer template.

Example with the `netbsd-6-amd64.json` template.

* Check that the template is valid:

        $ packer validate netbsd-6-amd64.json
        Template validated successfully.
        $

* Build the box image from the template:

        $ packer build netbsd-6-amd64.json
        ...
        ==> Builds finished. The artifacts of successful builds are:
        --> virtualbox-iso: VM files in directory: packer-netbsd-6.1.5-amd64-virtualbox
        --> virtualbox-iso: 'virtualbox' provider box: ./builds/netbsd-6.1.5-amd64-virtualbox.box
        $

* The box image is available in the `builds/` subdirectory.

## Available boxes

  * `netbsd-8-amd64.json` : Packer template for NetBSD 8.0 amd64
  * `netbsd-7-amd64.json` : Packer template for NetBSD 7.1.2 amd64
  * `netbsd-6-amd64.json` : Packer template for NetBSD 6.1.5 amd64


## Boxes without provisioners

By default the boxes have both Chef and Puppet installed,
from [pkgsrc](http://pkgsrc.org/) but they can be build
without any provisioner with a command like the following:


    $ packer build -var provisioner="" -var build_suffix=-provisionerless netbsd-6-amd64.json 
    ...
    ==> Builds finished. The artifacts of successful builds are:
    --> virtualbox-iso: VM files in directory: packer-netbsd-6.1.5-amd64-provisionerless-virtualbox
    --> virtualbox-iso: 'virtualbox' provider box: ./builds/netbsd-6.1.5-amd64-provisionerless-virtualbox.box
    $

Defining the Packer variable `build_suffix` is not required
but can be useful to name Packer's artifacts.

## Synced folders

VirtualBox shared folders are not supported as VirtualBox Guest
Additions are not available for NetBSD.

But Vagrant NFS synced folders are available.

It should be noted that a private ("host-only") network between the
virtualbox guest and the host must be setup to use NFS synced
folders.  The guest must also use a static IP address in this
network, specified in the Vagrantfile.

This is required for Vagrant before version 1.4. This limitation
was removed in Vagrant 1.4 but as VirtualBox Guest Additions are
not available for NetBSD, Vagrant cannot find out the guest's address
in this network. So a static IP address in the private network is
required, no matter the version of Vagrant used.

### Usage

Add something like the following to your `Vagrantfile`:

  
    Vagrant.configure("2") do |config|
      
      # Only NFS synced folder are supported.
      # And note that a private network with static IP is required
      config.vm.network :private_network, ip: "192.168.33.10"
      config.vm.synced_folder "/some/host/pathname", "/vagrant", type: "nfs"

    end

## ISO files

When needed Packer downloads NetBSD installation ISO image files.
If you already have them available you can put them, or symlink
them, into a subdirectory named `iso/`.

-stoned
