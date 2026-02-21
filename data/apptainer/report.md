# apptainer CWL Generation Report

## apptainer_build

### Tool Description
Build an Apptainer image

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.4K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Build an Apptainer image

Usage:
  apptainer build [local options...] <IMAGE PATH> <BUILD SPEC>

Description:

  IMAGE PATH:

  When Apptainer builds the container, output can be one of a few formats:

      default:    The compressed Apptainer read only image format (default)
      sandbox:    This is a read-write container within a directory structure

  note: It is a common workflow to use the "sandbox" mode for development of the
  container, and then build it as a default Apptainer image for production
  use. The default format is immutable.

  BUILD SPEC:

  The build spec target is a definition (def) file, local image, or URI that can 
  be used to create an Apptainer container. Several different local target
  formats exist:

      def file  : This is a recipe for building a container (examples below)
      directory:  A directory structure containing a (ch)root file system
      image:      A local image on your machine (will convert to sif if
                  it is legacy format)

  Targets can also be remote and defined by a URI of the following formats:

      library://  an image library (no default)
      docker://   a Docker/OCI registry (default Docker Hub)
      shub://     an Apptainer registry (default Singularity Hub)
      oras://     an OCI registry that holds SIF files using ORAS

  Temporary files:
  
  The location used for temporary directories defaults to '/tmp' but
  can be overridden by the TMPDIR environment variable, and that can be
  overridden by the APPTAINER_TMPDIR environment variable.  The
  temporary directory used during a build must be on a filesystem that
  has enough space to hold the entire container image, uncompressed,
  including any temporary files that are created and later removed
  during the build. You may need to set APPTAINER_TMPDIR or TMPDIR when
  building a large container on a system that has a small /tmp filesystem.

Options:
  -B, --bind stringArray         a user-bind path specification. spec has
                                 the format src[:dest[:opts]],where src
                                 and dest are outside and inside paths. If
                                 dest is not given,it is set equal to src.
                                 Mount options ('opts') may be specified
                                 as 'ro'(read-only) or 'rw' (read/write,
                                 which is the default).Multiple bind paths
                                 can be given by a comma separated list.
      --build-arg strings        defines variable=value to replace {{
                                 variable }} entries in build definition file
      --build-arg-file string    specifies a file containing
                                 variable=value lines to replace '{{
                                 variable }}' with value in build
                                 definition files
      --disable-cache            do not use cache or create cache
      --docker-host string       specify a custom Docker daemon host
      --docker-login             login to a Docker Repository interactively
  -e, --encrypt                  build an image with an encrypted file system
  -f, --fakeroot                 build with the appearance of running as
                                 root (default when building from a
                                 definition file unprivileged)
      --fix-perms                ensure owner has rwX permissions on all
                                 container content for oci/docker sources
  -F, --force                    overwrite an image file if it exists
  -h, --help                     help for build
      --json                     interpret build definition as JSON
      --library string           container Library URL
      --mount stringArray        a mount specification e.g.
                                 'type=bind,source=/opt,destination=/hostopt'.
      --no-cleanup               do NOT clean up bundle after failed
                                 build, can be helpful for debugging
      --no-https                 use http instead of https for docker://
                                 oras:// and library://<hostname>/... URIs
  -T, --notest                   build without running tests in %test section
      --nv                       inject host Nvidia libraries during build
                                 for post and test sections
      --nvccli                   use nvidia-container-cli for GPU setup
                                 (experimental)
      --passphrase               prompt for an encryption passphrase
      --pem-path string          enter an path to a PEM formatted RSA key
                                 for an encrypted container
      --rocm                     inject host Rocm libraries during build
                                 for post and test sections
  -s, --sandbox                  build image as sandbox format (chroot
                                 directory structure)
      --section strings          only run specific section(s) of deffile
                                 (setup, post, files, environment, test,
                                 labels, none) (default [all])
  -u, --update                   run definition over existing container
                                 (skips header)
      --userns                   build without using setuid even if available
      --warn-unused-build-args   shows warning instead of fatal message
                                 when build args are not exact matched
      --writable-tmpfs           during the %test section, makes the file
                                 system accessible as read-write with non
                                 persistent data (with overlay support only)


Examples:

  DEF FILE BASE OS:

      Library:
          Bootstrap: library
          From: debian:9

      Docker:
          Bootstrap: docker
          From: tensorflow/tensorflow:latest
          IncludeCmd: yes # Use the CMD as runscript instead of ENTRYPOINT

      Singularity Hub:
          Bootstrap: shub
          From: singularityhub/centos

      YUM/RHEL:
          Bootstrap: yum
          OSVersion: 7
          MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/x86_64/
          Include: yum

      SUSE:
          Bootstrap: zypper # on SLE system registration of build host is used
          Include: zypper
      
      openSUSE:
          Bootstrap: zypper
          MirrorURL: http://download.opensuse.org/distribution/openSUSE-stable/repo/oss
          Include: zypper

      Debian/Ubuntu:
          Bootstrap: debootstrap
          OSVersion: trusty
          MirrorURL: http://us.archive.ubuntu.com/ubuntu/

      Local Image:
          Bootstrap: localimage
          From: /home/dave/starter.img

      Scratch:
          Bootstrap: scratch # Populate the container with a minimal rootfs in %setup

  DEFFILE SECTIONS:

  The following sections are presented in the order of processing, with the exception
  that labels and environment can also be manipulated in %post.

      %pre
          echo "This is a scriptlet that will be executed on the host, as root before"
          echo "the container has been bootstrapped. This section is not commonly used."

      %setup
          echo "This is a scriptlet that will be executed on the host, as root, after"
          echo "the container has been bootstrapped. To install things into the container"
          echo "reference the file system location with $APPTAINER_ROOTFS."

      %files
          /path/on/host/file.txt /path/on/container/file.txt
          relative_file.txt /path/on/container/relative_file.txt

      %post
          echo "This scriptlet section will be executed from within the container after"
          echo "the bootstrap/base has been created and setup."

      %environment
          LUKE=goodguy
          VADER=badguy
          HAN=someguy
          export HAN VADER LUKE

      %test
          echo "Define any test commands that should be executed after container has been"
          echo "built. This scriptlet will be executed from within the running container"
          echo "as the root user. Pay attention to the exit/return value of this scriptlet"
          echo "as any non-zero exit code will be assumed as failure."
          exit 0

      %runscript
          echo "Define actions for the container to be executed with the run command or"
          echo "when container is executed."

      %startscript
          echo "Define actions for container to perform when started as an instance."

      %labels
          HELLO MOTO
          KEY VALUE

      %help
          This is a text file to be displayed with the run-help command.

  COMMANDS:

      Build a sif file from an Apptainer recipe file:
          $ apptainer build /tmp/debian0.sif /path/to/debian.def

      Build a sif image from the Library:
          $ apptainer build /tmp/debian1.sif library://debian:latest

      Build a base sandbox from DockerHub, make changes to it, then build sif
          $ apptainer build --sandbox /tmp/debian docker://debian:latest
          $ apptainer exec --writable /tmp/debian apt-get install python
          $ apptainer build /tmp/debian2.sif /tmp/debian


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_cache

### Tool Description
Manage your local Apptainer cache. You can list/clean using the specific types.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage the local cache

Usage:
  apptainer cache

Description:
  Manage your local Apptainer cache. You can list/clean using the specific
  types.

Options:
  -h, --help   help for cache

Available Commands:
  clean       Clean your local Apptainer cache
  list        List your local Apptainer cache

Examples:
  All group commands have their own help output:

  $ apptainer cache
  $ apptainer cache --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_capability

### Tool Description
Manage Linux capabilities for users and groups. Capabilities allow you to have fine grained control over the permissions that your containers need to run.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage Linux capabilities for users and groups

Usage:
  apptainer capability

Description:
  Capabilities allow you to have fine grained control over the permissions that
  your containers need to run.

  NOTE: capability add/drop commands require root to run. Granting capabilities 
  to users allows them to escalate privilege inside the container and will
  likely give them a route to privilege escalation on the host system as well.
  Do not add capabilities to users who should not have root on the host system.

Options:
  -h, --help   help for capability

Available Commands:
  add         Add capabilities to a user or group (requires root)
  avail       Show description for available capabilities
  drop        Remove capabilities from a user or group (requires root)
  list        Show capabilities for a given user or group

Examples:
  All group commands have their own help output:

  $ apptainer help capability add
  $ apptainer capability add --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_checkpoint

### Tool Description
Manage container checkpoint state (experimental)

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage container checkpoint state (experimental)

Usage:
  apptainer checkpoint

Description:
  The checkpoint command allows for the creation and management of container checkpoint state.

Options:
  -h, --help   help for checkpoint

Available Commands:
  create      Create empty checkpoint storage (experimental)
  delete      Delete a checkpoint (experimental)
  instance    Checkpoint the state of a running instance (experimental)
  list        List local checkpoints (experimental)

Examples:
  All checkpoint commands have their own help output:

  $ apptainer help checkpoint create
  $ apptainer checkpoint create --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_completion

### Tool Description
Generate the autocompletion script for apptainer for the specified shell.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Generate the autocompletion script for the specified shell

Usage:
  apptainer completion [flags]

Description:Generate the autocompletion script for apptainer for the specified shell.
See each sub-command's help for details on how to use the generated script.


Options:
  -h, --help   help for completion

Available Commands:
  bash        Generate the autocompletion script for bash
  fish        Generate the autocompletion script for fish
  powershell  Generate the autocompletion script for powershell
  zsh         Generate the autocompletion script for zsh


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_config

### Tool Description
Manage various apptainer configuration (root user only). The config command allows root user to manage various configuration like fakeroot user mapping entries.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage various apptainer configuration (root user only)

Usage:
  apptainer config

Description:
  The config command allows root user to manage various configuration like fakeroot
  user mapping entries.

Options:
  -h, --help   help for config

Available Commands:
  fakeroot    Manage fakeroot user mappings entries (root user only)
  global      Edit apptainer.conf from command line (root user only or unprivileged installation)

Examples:
  All config commands have their own help output:

  $ apptainer help config fakeroot
  $ apptainer config fakeroot --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_delete

### Tool Description
Deletes requested image from the library

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Deletes requested image from the library

Usage:
  apptainer delete [delete options...] <imageRef> [flags]

Description:
  The 'delete' command allows you to delete an image from a remote library.

Options:
  -A, --arch string      specify requested image arch (default "amd64")
  -F, --force            delete image without confirmation
  -h, --help             help for delete
      --library string   delete images from the provided library
      --no-https         use http instead of https for docker:// oras://
                         and library://<hostname>/... URIs


Examples:
  $ apptainer delete --arch=amd64 library://username/project/image:1.0


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_exec

### Tool Description
Run a command within a container

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Run a command within a container

Usage:
  apptainer exec [exec options...] <container> <command>

Description:
  apptainer exec supports the following formats:

  *.sif               Singularity Image Format (SIF). Native to Singularity
                      (3.0+) and Apptainer (v1.0.0+)
  
  *.sqsh              SquashFS format.  Native to Singularity 2.4+

  *.img               ext3 format. Native to Singularity versions < 2.4.

  directory/          sandbox format. Directory containing a valid root file 
                      system and optionally Apptainer meta-data.

  instance://*        A local running instance of a container. (See the instance
                      command group.)

  library://*         A SIF container hosted on a Library (no default)

  docker://*          A Docker/OCI container hosted on Docker Hub or another
                      OCI registry.

  shub://*            A container hosted on Singularity Hub.

  oras://*            A SIF container hosted on an OCI registry that supports
                      the OCI Registry As Storage (ORAS) specification.

Options:
      --add-caps string               a comma separated capability list to add
      --allow-setuid                  allow setuid binaries in container
                                      (root only)
      --app string                    set an application to run inside a
                                      container
      --apply-cgroups string          apply cgroups from file for
                                      container processes (root only)
  -B, --bind stringArray              a user-bind path specification. 
                                      spec has the format
                                      src[:dest[:opts]], where src and
                                      dest are outside and inside paths. 
                                      If dest is not given, it is set
                                      equal to src.  Mount options
                                      ('opts') may be specified as 'ro'
                                      (read-only) or 'rw' (read/write,
                                      which is the default). Multiple bind
                                      paths can be given by a comma
                                      separated list.
      --blkio-weight int              Block IO relative weight in range
                                      10-1000, 0 to disable
      --blkio-weight-device strings   Device specific block IO relative weight
  -e, --cleanenv                      clean environment before running
                                      container
      --compat                        apply settings for increased
                                      OCI/Docker compatibility. Infers
                                      --containall, --no-init, --no-umask,
                                      --no-eval, --writable-tmpfs.
  -c, --contain                       use minimal /dev and empty other
                                      directories (e.g. /tmp and $HOME)
                                      instead of sharing filesystems from
                                      your host
  -C, --containall                    contain not only file systems, but
                                      also PID, IPC, and environment
      --cpu-shares int                CPU shares for container (default -1)
      --cpus string                   Number of CPUs available to container
      --cpuset-cpus string            List of host CPUs available to container
      --cpuset-mems string            List of host memory nodes available
                                      to container
      --cwd string                    initial working directory for
                                      payload process inside the container
                                      (synonym for --pwd)
      --disable-cache                 do not use or create cache
      --dns string                    list of DNS server separated by
                                      commas to add in resolv.conf
      --docker-host string            specify a custom Docker daemon host
      --docker-login                  login to a Docker Repository
                                      interactively
      --drop-caps string              a comma separated capability list to drop
      --env stringToString            pass environment variable to
                                      contained process (default [])
      --env-file string               pass environment variables from file
                                      to contained process
  -f, --fakeroot                      run container with the appearance of
                                      running as root
      --fusemount strings             A FUSE filesystem mount
                                      specification of the form
                                      '<type>:<fuse command> <mountpoint>'
                                      - where <type> is 'container' or
                                      'host', specifying where the mount
                                      will be performed
                                      ('container-daemon' or 'host-daemon'
                                      will run the FUSE process detached).
                                      <fuse command> is the path to the
                                      FUSE executable, plus options for
                                      the mount. <mountpoint> is the
                                      location in the container to which
                                      the FUSE mount will be attached.
                                      E.g. 'container:sshfs 10.0.0.1:/
                                      /sshfs'. Implies --pid.
  -h, --help                          help for exec
  -H, --home string                   a home directory specification. 
                                      spec can either be a src path or
                                      src:dest pair.  src is the source
                                      path of the home directory outside
                                      the container and dest overrides the
                                      home directory within the container.
                                      (default "/user/qianghu")
      --hostname string               set container hostname
  -i, --ipc                           run container in a new IPC namespace
      --keep-privs                    let root user keep privileges in
                                      container (root only)
      --memory string                 Memory limit in bytes
      --memory-reservation string     Memory soft limit in bytes
      --memory-swap string            Swap limit, use -1 for unlimited swap
      --mount stringArray             a mount specification e.g.
                                      'type=bind,source=/opt,destination=/hostopt'.
  -n, --net                           run container in a new network
                                      namespace (sets up a bridge network
                                      interface by default)
      --network string                specify desired network type
                                      separated by commas, each network
                                      will bring up a dedicated interface
                                      inside container
      --network-args strings          specify network arguments to pass to
                                      CNI plugins
      --no-eval                       do not shell evaluate env vars or
                                      OCI container CMD/ENTRYPOINT/ARGS
      --no-home                       do NOT mount users home directory if
                                      /home is not the current working
                                      directory
      --no-https                      use http instead of https for
                                      docker:// oras:// and
                                      library://<hostname>/... URIs
      --no-init                       do NOT start shim process with --pid
      --no-mount strings              disable one or more 'mount xxx'
                                      options set in apptainer.conf and/or
                                      specify absolute destination path to
                                      disable a bind path entry, or
                                      'bind-paths' to disable all bind
                                      path entries.
      --no-pid                        do not run container in a new PID
                                      namespace
      --no-privs                      drop all privileges from root user
                                      in container)
      --no-umask                      do not propagate umask to the
                                      container, set default 0022 umask
      --nv                            enable Nvidia support
      --nvccli                        use nvidia-container-cli for GPU
                                      setup (experimental)
      --oom-kill-disable              Disable OOM killer
  -o, --overlay strings               use an overlayFS image for
                                      persistent data storage or as
                                      read-only layer of container
      --passphrase                    prompt for an encryption passphrase
      --pem-path string               enter an path to a PEM formatted RSA
                                      key for an encrypted container
  -p, --pid                           run container in a new PID namespace
      --pids-limit int                Limit number of container PIDs, use
                                      -1 for unlimited
      --rocm                          enable experimental Rocm support
  -S, --scratch strings               include a scratch directory within
                                      the container that is linked to a
                                      temporary dir (use -W to force location)
      --security strings              enable security features (SELinux,
                                      Apparmor, Seccomp)
      --sharens                       share the namespace and image with
                                      other containers launched from the
                                      same parent process
      --unsquash                      Convert SIF file to temporary
                                      sandbox before running
  -u, --userns                        run container in a new user namespace
      --uts                           run container in a new UTS namespace
  -W, --workdir string                working directory to be used for
                                      /tmp, /var/tmp and $HOME (if
                                      -c/--contain was also used)
  -w, --writable                      by default all Apptainer containers
                                      are available as read only. This
                                      option makes the file system
                                      accessible as read/write.
      --writable-tmpfs                makes the file system accessible as
                                      read-write with non persistent data
                                      (with overlay support only)


Examples:
  $ apptainer exec /tmp/debian.sif cat /etc/debian_version
  $ apptainer exec /tmp/debian.sif python ./hello_world.py
  $ cat hello_world.py | apptainer exec /tmp/debian.sif python
  $ sudo apptainer exec --writable /tmp/debian.sif apt-get update
  $ apptainer exec instance://my_instance ps -ef
  $ apptainer exec library://centos cat /etc/os-release


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_inspect

### Tool Description
Show metadata for an image. Inspect will show you labels, environment variables, apps and scripts associated with the image determined by the flags you pass.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Show metadata for an image

Usage:
  apptainer inspect [inspect options...] <image path>

Description:
  Inspect will show you labels, environment variables, apps and scripts associated 
  with the image determined by the flags you pass. By default, they will be shown in 
  plain text. If you would like to list them in json format, you should use the --json flag.
  

Options:
      --all           show all available data (imply --json option)
      --app string    inspect a specific app
  -d, --deffile       show the Apptainer definition file that was used to
                      generate the image
  -e, --environment   show the environment settings for the image
  -h, --help          help for inspect
  -H, --helpfile      inspect the runscript helpfile, if it exists
  -j, --json          print structured json instead of sections
  -l, --labels        show the labels for the image (default)
      --list-apps     list all apps in a container
  -r, --runscript     show the runscript for the image
  -s, --startscript   show the startscript for the image
  -t, --test          show the test script for the image


Examples:
  $ apptainer inspect ubuntu.sif
  
  If you want to list the applications (apps) installed in a container (located at
  /scif/apps) you should run inspect command with --list-apps <container-image> flag.
  ( See https://sci-f.github.io for more information on SCIF apps)

  The following environment variables are available to you when called 
  from the shell inside the container. The top variables are relevant 
  to the active app (--app <app>) and the bottom available for all 
  apps regardless of the active app. Both sets of variables are also available during development (at build time).

  ACTIVE APP ENVIRONMENT:
      SCIF_APPNAME       the name for the active application
      SCIF_APPROOT       the installation folder for the application created at /scif/apps/<app>
      SCIF_APPMETA       the application metadata folder
      SCIF_APPDATA       the data folder created for the application at /scif/data/<app>
        SCIF_APPINPUT    expected input folder within data base folder
        SCIF_APPOUTPUT   the output data folder within data base folder

      SCIF_APPENV        points to the application's custom environment.sh file in its metadata folder
      SCIF_APPLABELS     is the application's labels.json in the metadata folder
      SCIF_APPBIN        is the bin folder for the app, which is automatically added to the $PATH when the app is active
      SCIF_APPLIB        is the application's library folder that is added to the LD_LIBRARY_PATH
      SCIF_APPRUN        is the runscript
      SCIF_APPSTART      is the startscript
      SCIF_APPHELP       is the help file for the runscript
      SCIF_APPTEST       is the testing script (test.sh) associated with the application
      SCIF_APPNAME       the name for the active application
      SCIF_APPFILES      the files section associated with the application that are added to


  GLOBAL APP ENVIRONMENT:
    
      SCIF_DATA             scif defined data base for all apps (/scif/data)
      SCIF_APPS             scif defined install bases for all apps (/scif/apps)
      SCIF_APPROOT_<app>    root for application <app>
      SCIF_APPDATA_<app>    data root for application <app>

  To list all your apps:

  $ apptainer inspect --list-apps ubuntu.sif

  To list only labels in the json format from an image:

  $ apptainer inspect --json --labels ubuntu.sif

  To verify you own a single application on your container image, use the --app <appname> flag:

  $ apptainer inspect --app <appname> ubuntu.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_instance

### Tool Description
Manage containers running as services. Instances allow you to run containers as background processes. This can be useful for running services such as web servers or databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage containers running as services

Usage:
  apptainer instance

Description:
  Instances allow you to run containers as background processes. This can be
  useful for running services such as web servers or databases.

Options:
  -h, --help   help for instance

Available Commands:
  list        List all running and named Apptainer instances
  run         Run a named instance of the given container image
  start       Start a named instance of the given container image
  stats       Get stats for a named instance
  stop        Stop a named instance of a given container image

Examples:
  All group commands have their own help output:

  $ apptainer help instance start
  $ apptainer instance start --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_key

### Tool Description
Manage your trusted, public and private keys in your local or in the global keyring (local keyring: '~/.apptainer/keys' if 'APPTAINER_KEYSDIR' is not set, global keyring: '/usr/local/etc/apptainer/global-pgp-public')

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage OpenPGP keys

Usage:
  apptainer key [key options...]

Description:
  Manage your trusted, public and private keys in your local or in the global keyring
  (local keyring: '~/.apptainer/keys' if 'APPTAINER_KEYSDIR' is not set,
  global keyring: '/usr/local/etc/apptainer/global-pgp-public')

Options:
  -h, --help   help for key

Available Commands:
  export      Export a public or private key into a specific file
  import      Import a local key into the local or global keyring
  list        List keys in your local or in the global keyring
  newpair     Create a new key pair
  pull        Download a public key from a key server
  push        Upload a public key to a key server
  remove      Remove a local public key from your local or the global keyring
  search      Search for keys on a key server

Examples:
  All group commands have their own help output:

  $ apptainer help key newpair
  $ apptainer key list --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_keyserver

### Tool Description
The 'keyserver' command allows you to manage standalone keyservers that will be used for retrieving cryptographic keys.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage apptainer keyservers

Usage:
  apptainer keyserver [subcommand options...]

Description:
  The 'keyserver' command allows you to manage standalone keyservers that will 
  be used for retrieving cryptographic keys.

Options:
  -c, --config string   path to the file holding keyserver configurations
                        (default "/user/qianghu/.apptainer/remote.yaml")
  -h, --help            help for keyserver

Available Commands:
  add         Add a keyserver (root user only)
  list        List all keyservers that are configured
  login       Login to a keyserver
  logout      Logout from a keyserver
  remove      Remove a keyserver (root user only)

Examples:
  All group commands have their own help output:

    $ apptainer help keyserver add
    $ apptainer keyserver add


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_oci

### Tool Description
Manage OCI containers. Allow you to manage containers from OCI bundle directories. NOTE: all oci commands requires to run as root.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage OCI containers

Usage:
  apptainer oci

Description:
  Allow you to manage containers from OCI bundle directories.

  NOTE: all oci commands requires to run as root

Options:
  -h, --help   help for oci

Available Commands:
  attach      Attach console to a running container process (root user only)
  create      Create a container from a bundle directory (root user only)
  delete      Delete container (root user only)
  exec        Execute a command within container (root user only)
  kill        Kill a container (root user only)
  mount       Mount create an OCI bundle from SIF image (root user only)
  pause       Suspends all processes inside the container (root user only)
  resume      Resumes all processes previously paused inside the container (root user only)
  run         Create/start/attach/delete a container from a bundle directory (root user only)
  start       Start container process (root user only)
  state       Query state of a container (root user only)
  umount      Umount delete bundle (root user only)
  update      Update container cgroups resources (root user only)

Examples:
  All group commands have their own help output:

  $ apptainer oci create -b ~/bundle mycontainer
  $ apptainer oci start mycontainer


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_overlay

### Tool Description
The overlay command allows management of EXT3 writable overlay images.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage an EXT3 writable overlay image

Usage:
  apptainer overlay

Description:
  The overlay command allows management of EXT3 writable overlay images.

Options:
  -h, --help   help for overlay

Available Commands:
  create      Create EXT3 writable overlay image

Examples:
  All overlay commands have their own help output:

  $ apptainer help overlay create
  $ apptainer overlay create --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_plugin

### Tool Description
The 'plugin' command allows you to manage Apptainer plugins which provide add-on functionality to the default Apptainer installation.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage Apptainer plugins

Usage:
  apptainer plugin [plugin options...]

Description:
  The 'plugin' command allows you to manage Apptainer plugins which
  provide add-on functionality to the default Apptainer installation.

Options:
  -h, --help   help for plugin

Available Commands:
  compile     Compile an Apptainer plugin
  create      Create a plugin skeleton directory
  disable     disable an installed Apptainer plugin
  enable      Enable an installed Apptainer plugin
  inspect     Inspect an Apptainer plugin (either an installed one or an image)
  install     Install a compiled Apptainer plugin
  list        List installed Apptainer plugins
  uninstall   Uninstall removes the named plugin from the system

Examples:
  All group commands have their own help output:

  $ apptainer help plugin compile
  $ apptainer plugin list --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_pull

### Tool Description
The 'pull' command allows you to download or build a container from a given URI.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Pull an image from a URI

Usage:
  apptainer pull [pull options...] [output file] <URI>

Description:
  The 'pull' command allows you to download or build a container from a given
  URI. Supported URIs include:

  library: Pull an image from the currently configured library
      library://user/collection/container[:tag]

  docker: Pull a Docker/OCI image from Docker Hub, or another OCI registry.
      docker://user/image:tag
    
  shub: Pull an image from Singularity Hub
      shub://user/image:tag

  oras: Pull a SIF image from an OCI registry that supports ORAS.
      oras://registry/namespace/image:tag

  http, https: Pull an image using the http(s?) protocol
      https://example.com/alpine.sif

Options:
      --arch string           architecture to pull from library (default
                              "amd64")
      --arch-variant string   architecture variant to pull from library
      --dir string            download images to the specific directory
      --disable-cache         do not use or create cached images/blobs
      --docker-host string    specify a custom Docker daemon host
      --docker-login          login to a Docker Repository interactively
  -F, --force                 overwrite an image file if it exists
  -h, --help                  help for pull
      --library string        download images from the provided library
      --no-cleanup            do NOT clean up bundle after failed build,
                              can be helpful for debugging
      --no-https              use http instead of https for docker://
                              oras:// and library://<hostname>/... URIs


Examples:
  From a library
  $ apptainer pull alpine.sif library://alpine:latest

  From Docker
  $ apptainer pull tensorflow.sif docker://tensorflow/tensorflow:latest
  $ apptainer pull --arch arm --arch-variant 6 alpine.sif docker://alpine:latest

  From Shub
  $ apptainer pull apptainer-images.sif shub://vsoch/apptainer-images

  From supporting OCI registry (e.g. Azure Container Registry)
  $ apptainer pull image.sif oras://<username>.azurecr.io/namespace/image:tag


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_push

### Tool Description
Upload image to the provided URI. The 'push' command allows you to upload a SIF container to a given URI (library:// or oras://).

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Upload image to the provided URI

Usage:
  apptainer push [push options...] <image> <URI>

Description:
  The 'push' command allows you to upload a SIF container to a given
  URI.  Supported URIs include:

  library:
      library://user/collection/container[:tag]

  oras:
      oras://registry/namespace/image:tag


  NOTE: It's always good practice to sign your containers before
  pushing them to the library. An auth token is required to push to the library,
  so you may need to configure it first with 'apptainer remote'.

Options:
  -U, --allow-unsigned       do not require a signed container image
  -D, --description string   description for container image (library:// only)
      --docker-host string   specify a custom Docker daemon host
  -h, --help                 help for push
      --library string       the library to push to
      --no-https             use http instead of https for docker://
                             oras:// and library://<hostname>/... URIs


Examples:
  To Library
  $ apptainer push /home/user/my.sif library://user/collection/my.sif:latest

  To supported OCI registry
  $ apptainer push /home/user/my.sif oras://registry/namespace/image:tag


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_registry

### Tool Description
Manage authentication to OCI/Docker registries. The 'registry' command allows you to manage authentication to standalone OCI/Docker registries, such as 'docker://' or 'oras://'.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage authentication to OCI/Docker registries

Usage:
  apptainer registry [subcommand options...]

Description:
  The 'registry' command allows you to manage authentication to standalone OCI/Docker
  registries, such as 'docker://'' or 'oras://'.

Options:
  -c, --config string   path to the file holding registry configurations
                        (default "/user/qianghu/.apptainer/remote.yaml")
  -h, --help            help for registry

Available Commands:
  list        List all OCI credentials that are configured
  login       Login to an OCI/Docker registry
  logout      Logout from an OCI/Docker registry

Examples:
  All group commands have their own help output:

    $ apptainer help registry login
    $ apptainer registry login


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_remote

### Tool Description
Manage apptainer remote endpoints through its subcommands. A 'remote endpoint' is a group of services compatible with the container library API.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manage apptainer remote endpoints

Usage:
  apptainer remote [remote options...]

Description:
  The 'remote' command allows you to manage Apptainer remote endpoints through
  its subcommands.

  A 'remote endpoint' is a group of services that is compatible with the
  container library API.  The remote endpoint is a single address,
  e.g. 'cloud.example.com' through which library and/or keystore services
  will be automatically discovered.

  To configure a remote endpoint you must 'remote add' it. You can 'remote login' if
  you will be performing actions needing authentication. Switch between
  configured remote endpoints with the 'remote use' command. The active remote
  endpoint will be used for key operations, and 'library://' pull
  and push. You can also 'remote logout' from and 'remote remove' an endpoint that
  is no longer required.

  The remote configuration is stored in $HOME/.apptainer/remotes.yaml by default.

Options:
  -c, --config string   path to the file holding remote endpoint
                        configurations (default
                        "/user/qianghu/.apptainer/remote.yaml")
  -h, --help            help for remote

Available Commands:
  add                Add a new apptainer remote endpoint
  get-login-password Retrieves the cli secret for the current logged in user
  list               List all apptainer remote endpoints that are configured
  login              Login to an apptainer remote endpoint
  logout             Log out from an apptainer remote endpoint
  remove             Remove an existing apptainer remote endpoint
  status             Check the status of the apptainer services at an endpoint, and your authentication token
  use                Set an Apptainer remote endpoint to be actively used

Examples:
  All group commands have their own help output:

    $ apptainer help remote list
    $ apptainer remote list


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_run

### Tool Description
Run the user-defined default command within a container. This command will launch an Apptainer container and execute a runscript if one is defined for that container.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Run the user-defined default command within a container

Usage:
  apptainer run [run options...] <container> [args...]

Description:
  This command will launch an Apptainer container and execute a runscript
  if one is defined for that container. The runscript is a metadata file within
  the container that contains shell commands. If the file is present (and
  executable) then this command will execute that file within the container
  automatically. All arguments following the container name will be passed
  directly to the runscript.

  apptainer run accepts the following container formats:

  *.sif               Singularity Image Format (SIF). Native to Singularity
                      (3.0+) and Apptainer (v1.0.0+)
  
  *.sqsh              SquashFS format.  Native to Singularity 2.4+

  *.img               ext3 format. Native to Singularity versions < 2.4.

  directory/          sandbox format. Directory containing a valid root file 
                      system and optionally Apptainer meta-data.

  instance://*        A local running instance of a container. (See the instance
                      command group.)

  library://*         A SIF container hosted on a Library (no default)

  docker://*          A Docker/OCI container hosted on Docker Hub or another
                      OCI registry.

  shub://*            A container hosted on Singularity Hub.

  oras://*            A SIF container hosted on an OCI registry that supports
                      the OCI Registry As Storage (ORAS) specification.

Options:
      --add-caps string               a comma separated capability list to add
      --allow-setuid                  allow setuid binaries in container
                                      (root only)
      --app string                    set an application to run inside a
                                      container
      --apply-cgroups string          apply cgroups from file for
                                      container processes (root only)
  -B, --bind stringArray              a user-bind path specification. 
                                      spec has the format
                                      src[:dest[:opts]], where src and
                                      dest are outside and inside paths. 
                                      If dest is not given, it is set
                                      equal to src.  Mount options
                                      ('opts') may be specified as 'ro'
                                      (read-only) or 'rw' (read/write,
                                      which is the default). Multiple bind
                                      paths can be given by a comma
                                      separated list.
      --blkio-weight int              Block IO relative weight in range
                                      10-1000, 0 to disable
      --blkio-weight-device strings   Device specific block IO relative weight
  -e, --cleanenv                      clean environment before running
                                      container
      --compat                        apply settings for increased
                                      OCI/Docker compatibility. Infers
                                      --containall, --no-init, --no-umask,
                                      --no-eval, --writable-tmpfs.
  -c, --contain                       use minimal /dev and empty other
                                      directories (e.g. /tmp and $HOME)
                                      instead of sharing filesystems from
                                      your host
  -C, --containall                    contain not only file systems, but
                                      also PID, IPC, and environment
      --cpu-shares int                CPU shares for container (default -1)
      --cpus string                   Number of CPUs available to container
      --cpuset-cpus string            List of host CPUs available to container
      --cpuset-mems string            List of host memory nodes available
                                      to container
      --cwd string                    initial working directory for
                                      payload process inside the container
                                      (synonym for --pwd)
      --disable-cache                 do not use or create cache
      --dns string                    list of DNS server separated by
                                      commas to add in resolv.conf
      --docker-host string            specify a custom Docker daemon host
      --docker-login                  login to a Docker Repository
                                      interactively
      --drop-caps string              a comma separated capability list to drop
      --env stringToString            pass environment variable to
                                      contained process (default [])
      --env-file string               pass environment variables from file
                                      to contained process
  -f, --fakeroot                      run container with the appearance of
                                      running as root
      --fusemount strings             A FUSE filesystem mount
                                      specification of the form
                                      '<type>:<fuse command> <mountpoint>'
                                      - where <type> is 'container' or
                                      'host', specifying where the mount
                                      will be performed
                                      ('container-daemon' or 'host-daemon'
                                      will run the FUSE process detached).
                                      <fuse command> is the path to the
                                      FUSE executable, plus options for
                                      the mount. <mountpoint> is the
                                      location in the container to which
                                      the FUSE mount will be attached.
                                      E.g. 'container:sshfs 10.0.0.1:/
                                      /sshfs'. Implies --pid.
  -h, --help                          help for run
  -H, --home string                   a home directory specification. 
                                      spec can either be a src path or
                                      src:dest pair.  src is the source
                                      path of the home directory outside
                                      the container and dest overrides the
                                      home directory within the container.
                                      (default "/user/qianghu")
      --hostname string               set container hostname
  -i, --ipc                           run container in a new IPC namespace
      --keep-privs                    let root user keep privileges in
                                      container (root only)
      --memory string                 Memory limit in bytes
      --memory-reservation string     Memory soft limit in bytes
      --memory-swap string            Swap limit, use -1 for unlimited swap
      --mount stringArray             a mount specification e.g.
                                      'type=bind,source=/opt,destination=/hostopt'.
  -n, --net                           run container in a new network
                                      namespace (sets up a bridge network
                                      interface by default)
      --network string                specify desired network type
                                      separated by commas, each network
                                      will bring up a dedicated interface
                                      inside container
      --network-args strings          specify network arguments to pass to
                                      CNI plugins
      --no-eval                       do not shell evaluate env vars or
                                      OCI container CMD/ENTRYPOINT/ARGS
      --no-home                       do NOT mount users home directory if
                                      /home is not the current working
                                      directory
      --no-https                      use http instead of https for
                                      docker:// oras:// and
                                      library://<hostname>/... URIs
      --no-init                       do NOT start shim process with --pid
      --no-mount strings              disable one or more 'mount xxx'
                                      options set in apptainer.conf and/or
                                      specify absolute destination path to
                                      disable a bind path entry, or
                                      'bind-paths' to disable all bind
                                      path entries.
      --no-pid                        do not run container in a new PID
                                      namespace
      --no-privs                      drop all privileges from root user
                                      in container)
      --no-umask                      do not propagate umask to the
                                      container, set default 0022 umask
      --nv                            enable Nvidia support
      --nvccli                        use nvidia-container-cli for GPU
                                      setup (experimental)
      --oom-kill-disable              Disable OOM killer
  -o, --overlay strings               use an overlayFS image for
                                      persistent data storage or as
                                      read-only layer of container
      --passphrase                    prompt for an encryption passphrase
      --pem-path string               enter an path to a PEM formatted RSA
                                      key for an encrypted container
  -p, --pid                           run container in a new PID namespace
      --pids-limit int                Limit number of container PIDs, use
                                      -1 for unlimited
      --rocm                          enable experimental Rocm support
  -S, --scratch strings               include a scratch directory within
                                      the container that is linked to a
                                      temporary dir (use -W to force location)
      --security strings              enable security features (SELinux,
                                      Apparmor, Seccomp)
      --sharens                       share the namespace and image with
                                      other containers launched from the
                                      same parent process
      --unsquash                      Convert SIF file to temporary
                                      sandbox before running
  -u, --userns                        run container in a new user namespace
      --uts                           run container in a new UTS namespace
  -W, --workdir string                working directory to be used for
                                      /tmp, /var/tmp and $HOME (if
                                      -c/--contain was also used)
  -w, --writable                      by default all Apptainer containers
                                      are available as read only. This
                                      option makes the file system
                                      accessible as read/write.
      --writable-tmpfs                makes the file system accessible as
                                      read-write with non persistent data
                                      (with overlay support only)


Examples:
  # Here we see that the runscript prints "Hello world: "
  $ apptainer exec /tmp/debian.sif cat /apptainer
  #!/bin/sh
  echo "Hello world: "

  # It runs with our inputs when we run the image
  $ apptainer run /tmp/debian.sif one two three
  Hello world: one two three

  # Note that this does the same thing
  $ ./tmp/debian.sif one two three


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_run-help

### Tool Description
Show the user-defined help for an image

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Show the user-defined help for an image

Usage:
  apptainer run-help <image path>

Description:
  The help text is from the '%help' section of the definition file. If you are 
  using the '--apps' option, the help text is instead from that app's '%apphelp' 
  section.

Options:
      --app string   show the help for an app
  -h, --help         help for run-help


Examples:
  $ cat my_container.def
  Bootstrap: docker
  From: busybox

  %help
      Some help for this container

  %apphelp foo
      Some help for application 'foo' in this container

  $ sudo apptainer build my_container.sif my_container.def
  Using container recipe deffile: my_container.def
  [...snip...]
  Cleaning up...

  $ apptainer run-help my_container.sif

    Some help for this container

  $ apptainer run-help --app foo my_container.sif

    Some help for application in this container


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_search

### Tool Description
Search a Container Library for container images matching the search query. You can specify an alternate architecture, and/or limit the results to only signed images.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Search a Container Library for images

Usage:
  apptainer search [search options...] <search_query>

Description:
  Search a Container Library for container images matching the search query.
  You can specify an alternate architecture, and/or limit
  the results to only signed images.

Options:
      --arch string      architecture to search for (default "amd64")
  -h, --help             help for search
      --library string   URI for library to search
      --signed           search for only signed images


Examples:
  $ apptainer search lolcow
  $ apptainer search --arch arm64 alpine
  $ apptainer search --signed tensorflow


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_shell

### Tool Description
Run a shell within a container

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Run a shell within a container

Usage:
  apptainer shell [shell options...] <container>

Description:
  apptainer shell supports the following formats:

  *.sif               Singularity Image Format (SIF). Native to Singularity
                      (3.0+) and Apptainer (v1.0.0+)
  
  *.sqsh              SquashFS format.  Native to Singularity 2.4+

  *.img               ext3 format. Native to Singularity versions < 2.4.

  directory/          sandbox format. Directory containing a valid root file 
                      system and optionally Apptainer meta-data.

  instance://*        A local running instance of a container. (See the instance
                      command group.)

  library://*         A SIF container hosted on a Library (no default)

  docker://*          A Docker/OCI container hosted on Docker Hub or another
                      OCI registry.

  shub://*            A container hosted on Singularity Hub.

  oras://*            A SIF container hosted on an OCI registry that supports
                      the OCI Registry As Storage (ORAS) specification.

Options:
      --add-caps string               a comma separated capability list to add
      --allow-setuid                  allow setuid binaries in container
                                      (root only)
      --app string                    set an application to run inside a
                                      container
      --apply-cgroups string          apply cgroups from file for
                                      container processes (root only)
  -B, --bind stringArray              a user-bind path specification. 
                                      spec has the format
                                      src[:dest[:opts]], where src and
                                      dest are outside and inside paths. 
                                      If dest is not given, it is set
                                      equal to src.  Mount options
                                      ('opts') may be specified as 'ro'
                                      (read-only) or 'rw' (read/write,
                                      which is the default). Multiple bind
                                      paths can be given by a comma
                                      separated list.
      --blkio-weight int              Block IO relative weight in range
                                      10-1000, 0 to disable
      --blkio-weight-device strings   Device specific block IO relative weight
  -e, --cleanenv                      clean environment before running
                                      container
      --compat                        apply settings for increased
                                      OCI/Docker compatibility. Infers
                                      --containall, --no-init, --no-umask,
                                      --no-eval, --writable-tmpfs.
  -c, --contain                       use minimal /dev and empty other
                                      directories (e.g. /tmp and $HOME)
                                      instead of sharing filesystems from
                                      your host
  -C, --containall                    contain not only file systems, but
                                      also PID, IPC, and environment
      --cpu-shares int                CPU shares for container (default -1)
      --cpus string                   Number of CPUs available to container
      --cpuset-cpus string            List of host CPUs available to container
      --cpuset-mems string            List of host memory nodes available
                                      to container
      --cwd string                    initial working directory for
                                      payload process inside the container
                                      (synonym for --pwd)
      --disable-cache                 do not use or create cache
      --dns string                    list of DNS server separated by
                                      commas to add in resolv.conf
      --docker-host string            specify a custom Docker daemon host
      --docker-login                  login to a Docker Repository
                                      interactively
      --drop-caps string              a comma separated capability list to drop
      --env stringToString            pass environment variable to
                                      contained process (default [])
      --env-file string               pass environment variables from file
                                      to contained process
  -f, --fakeroot                      run container with the appearance of
                                      running as root
      --fusemount strings             A FUSE filesystem mount
                                      specification of the form
                                      '<type>:<fuse command> <mountpoint>'
                                      - where <type> is 'container' or
                                      'host', specifying where the mount
                                      will be performed
                                      ('container-daemon' or 'host-daemon'
                                      will run the FUSE process detached).
                                      <fuse command> is the path to the
                                      FUSE executable, plus options for
                                      the mount. <mountpoint> is the
                                      location in the container to which
                                      the FUSE mount will be attached.
                                      E.g. 'container:sshfs 10.0.0.1:/
                                      /sshfs'. Implies --pid.
  -h, --help                          help for shell
  -H, --home string                   a home directory specification. 
                                      spec can either be a src path or
                                      src:dest pair.  src is the source
                                      path of the home directory outside
                                      the container and dest overrides the
                                      home directory within the container.
                                      (default "/user/qianghu")
      --hostname string               set container hostname
  -i, --ipc                           run container in a new IPC namespace
      --keep-privs                    let root user keep privileges in
                                      container (root only)
      --memory string                 Memory limit in bytes
      --memory-reservation string     Memory soft limit in bytes
      --memory-swap string            Swap limit, use -1 for unlimited swap
      --mount stringArray             a mount specification e.g.
                                      'type=bind,source=/opt,destination=/hostopt'.
  -n, --net                           run container in a new network
                                      namespace (sets up a bridge network
                                      interface by default)
      --network string                specify desired network type
                                      separated by commas, each network
                                      will bring up a dedicated interface
                                      inside container
      --network-args strings          specify network arguments to pass to
                                      CNI plugins
      --no-eval                       do not shell evaluate env vars or
                                      OCI container CMD/ENTRYPOINT/ARGS
      --no-home                       do NOT mount users home directory if
                                      /home is not the current working
                                      directory
      --no-https                      use http instead of https for
                                      docker:// oras:// and
                                      library://<hostname>/... URIs
      --no-init                       do NOT start shim process with --pid
      --no-mount strings              disable one or more 'mount xxx'
                                      options set in apptainer.conf and/or
                                      specify absolute destination path to
                                      disable a bind path entry, or
                                      'bind-paths' to disable all bind
                                      path entries.
      --no-pid                        do not run container in a new PID
                                      namespace
      --no-privs                      drop all privileges from root user
                                      in container)
      --no-umask                      do not propagate umask to the
                                      container, set default 0022 umask
      --nv                            enable Nvidia support
      --nvccli                        use nvidia-container-cli for GPU
                                      setup (experimental)
      --oom-kill-disable              Disable OOM killer
  -o, --overlay strings               use an overlayFS image for
                                      persistent data storage or as
                                      read-only layer of container
      --passphrase                    prompt for an encryption passphrase
      --pem-path string               enter an path to a PEM formatted RSA
                                      key for an encrypted container
  -p, --pid                           run container in a new PID namespace
      --pids-limit int                Limit number of container PIDs, use
                                      -1 for unlimited
      --rocm                          enable experimental Rocm support
  -S, --scratch strings               include a scratch directory within
                                      the container that is linked to a
                                      temporary dir (use -W to force location)
      --security strings              enable security features (SELinux,
                                      Apparmor, Seccomp)
      --sharens                       share the namespace and image with
                                      other containers launched from the
                                      same parent process
  -s, --shell string                  path to program to use for
                                      interactive shell
      --unsquash                      Convert SIF file to temporary
                                      sandbox before running
  -u, --userns                        run container in a new user namespace
      --uts                           run container in a new UTS namespace
  -W, --workdir string                working directory to be used for
                                      /tmp, /var/tmp and $HOME (if
                                      -c/--contain was also used)
  -w, --writable                      by default all Apptainer containers
                                      are available as read only. This
                                      option makes the file system
                                      accessible as read/write.
      --writable-tmpfs                makes the file system accessible as
                                      read-write with non persistent data
                                      (with overlay support only)


Examples:
  $ apptainer shell /tmp/Debian.sif
  Apptainer/Debian.sif> pwd
  /home/gmk/test
  Apptainer/Debian.sif> exit

  $ apptainer shell -C /tmp/Debian.sif
  Apptainer/Debian.sif> pwd
  /home/gmk
  Apptainer/Debian.sif> ls -l
  total 0
  Apptainer/Debian.sif> exit

  $ sudo apptainer shell -w /tmp/Debian.sif
  $ sudo apptainer shell --writable /tmp/Debian.sif

  $ apptainer shell instance://my_instance

  $ apptainer shell instance://my_instance
  Apptainer: Invoking an interactive shell within container...
  Apptainer container:~> ps -ef
  UID        PID  PPID  C STIME TTY          TIME CMD
  ubuntu       1     0  0 20:00 ?        00:00:00 /usr/local/bin/apptainer/bin/appinit
  ubuntu       2     0  0 20:01 pts/8    00:00:00 /bin/bash --norc
  ubuntu       3     2  0 20:02 pts/8    00:00:00 ps -ef


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif

### Tool Description
Manipulate Singularity Image Format (SIF) images. A set of commands are provided to display elements such as the SIF global header, the data object descriptors and to dump data objects. It is also possible to modify a SIF file via this tool via the add/del commands.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Manipulate Singularity Image Format (SIF) images

Usage:
  apptainer sif

Description:
  A set of commands are provided to display elements such as the SIF global
  header, the data object descriptors and to dump data objects. It is also
  possible to modify a SIF file via this tool via the add/del commands.

Options:
  -h, --help   help for sif

Available Commands:
  add         Add data object
  del         Delete data object
  dump        Dump data object
  header      Display global header
  info        Display data object info
  list        List data objects
  new         Create SIF image
  setprim     Set primary system partition

Examples:
  All sif commands have their own help output:

  $ apptainer help sif list
  $ apptainer sif list --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sign

### Tool Description
Add digital signature(s) to an image. The sign command allows a user to add one or more digital signatures to a SIF image. By default, one digital signature is added for each object group in the file.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Add digital signature(s) to an image

Usage:
  apptainer sign [sign options...] <image path>

Description:
  The sign command allows a user to add one or more digital signatures to a SIF
  image. By default, one digital signature is added for each object group in
  the file.

  Key material can be provided via PEM-encoded file, or an entity in the PGP
  keyring. To manage the PGP keyring, see 'apptainer help key'.

Options:
  -g, --group-id uint32   sign objects with the specified group ID
  -h, --help              help for sign
      --key string        path to the private key file
  -k, --keyidx int        PGP private key to use (index from 'key list
                          --secret')
  -i, --sif-id uint32     sign object with the specified ID


Examples:
  Sign with a private key:
  $ apptainer sign --key private.pem container.sif

  Sign with PGP:
  $ apptainer sign container.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_test

### Tool Description
Run the user-defined tests within a container

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Run the user-defined tests within a container

Usage:
  apptainer test [exec options...] <image path>

Description:
  The 'test' command allows you to execute a testscript (if available) inside of
  a given container 

  NOTE:
      For instances if there is a daemon process running inside the container,
      then subsequent container commands will all run within the same 
      namespaces. This means that the --writable and --contain options will not 
      be honored as the namespaces have already been configured by the 
      'apptainer start' command.


Options:
      --add-caps string               a comma separated capability list to add
      --allow-setuid                  allow setuid binaries in container
                                      (root only)
      --app string                    set an application to run inside a
                                      container
      --apply-cgroups string          apply cgroups from file for
                                      container processes (root only)
  -B, --bind stringArray              a user-bind path specification. 
                                      spec has the format
                                      src[:dest[:opts]], where src and
                                      dest are outside and inside paths. 
                                      If dest is not given, it is set
                                      equal to src.  Mount options
                                      ('opts') may be specified as 'ro'
                                      (read-only) or 'rw' (read/write,
                                      which is the default). Multiple bind
                                      paths can be given by a comma
                                      separated list.
      --blkio-weight int              Block IO relative weight in range
                                      10-1000, 0 to disable
      --blkio-weight-device strings   Device specific block IO relative weight
  -e, --cleanenv                      clean environment before running
                                      container
      --compat                        apply settings for increased
                                      OCI/Docker compatibility. Infers
                                      --containall, --no-init, --no-umask,
                                      --no-eval, --writable-tmpfs.
  -c, --contain                       use minimal /dev and empty other
                                      directories (e.g. /tmp and $HOME)
                                      instead of sharing filesystems from
                                      your host
  -C, --containall                    contain not only file systems, but
                                      also PID, IPC, and environment
      --cpu-shares int                CPU shares for container (default -1)
      --cpus string                   Number of CPUs available to container
      --cpuset-cpus string            List of host CPUs available to container
      --cpuset-mems string            List of host memory nodes available
                                      to container
      --cwd string                    initial working directory for
                                      payload process inside the container
                                      (synonym for --pwd)
      --disable-cache                 do not use or create cache
      --dns string                    list of DNS server separated by
                                      commas to add in resolv.conf
      --docker-host string            specify a custom Docker daemon host
      --docker-login                  login to a Docker Repository
                                      interactively
      --drop-caps string              a comma separated capability list to drop
      --env stringToString            pass environment variable to
                                      contained process (default [])
      --env-file string               pass environment variables from file
                                      to contained process
  -f, --fakeroot                      run container with the appearance of
                                      running as root
      --fusemount strings             A FUSE filesystem mount
                                      specification of the form
                                      '<type>:<fuse command> <mountpoint>'
                                      - where <type> is 'container' or
                                      'host', specifying where the mount
                                      will be performed
                                      ('container-daemon' or 'host-daemon'
                                      will run the FUSE process detached).
                                      <fuse command> is the path to the
                                      FUSE executable, plus options for
                                      the mount. <mountpoint> is the
                                      location in the container to which
                                      the FUSE mount will be attached.
                                      E.g. 'container:sshfs 10.0.0.1:/
                                      /sshfs'. Implies --pid.
  -h, --help                          help for test
  -H, --home string                   a home directory specification. 
                                      spec can either be a src path or
                                      src:dest pair.  src is the source
                                      path of the home directory outside
                                      the container and dest overrides the
                                      home directory within the container.
                                      (default "/user/qianghu")
      --hostname string               set container hostname
  -i, --ipc                           run container in a new IPC namespace
      --keep-privs                    let root user keep privileges in
                                      container (root only)
      --memory string                 Memory limit in bytes
      --memory-reservation string     Memory soft limit in bytes
      --memory-swap string            Swap limit, use -1 for unlimited swap
      --mount stringArray             a mount specification e.g.
                                      'type=bind,source=/opt,destination=/hostopt'.
  -n, --net                           run container in a new network
                                      namespace (sets up a bridge network
                                      interface by default)
      --network string                specify desired network type
                                      separated by commas, each network
                                      will bring up a dedicated interface
                                      inside container
      --network-args strings          specify network arguments to pass to
                                      CNI plugins
      --no-eval                       do not shell evaluate env vars or
                                      OCI container CMD/ENTRYPOINT/ARGS
      --no-home                       do NOT mount users home directory if
                                      /home is not the current working
                                      directory
      --no-https                      use http instead of https for
                                      docker:// oras:// and
                                      library://<hostname>/... URIs
      --no-init                       do NOT start shim process with --pid
      --no-mount strings              disable one or more 'mount xxx'
                                      options set in apptainer.conf and/or
                                      specify absolute destination path to
                                      disable a bind path entry, or
                                      'bind-paths' to disable all bind
                                      path entries.
      --no-pid                        do not run container in a new PID
                                      namespace
      --no-privs                      drop all privileges from root user
                                      in container)
      --no-umask                      do not propagate umask to the
                                      container, set default 0022 umask
      --nv                            enable Nvidia support
      --nvccli                        use nvidia-container-cli for GPU
                                      setup (experimental)
      --oom-kill-disable              Disable OOM killer
  -o, --overlay strings               use an overlayFS image for
                                      persistent data storage or as
                                      read-only layer of container
      --passphrase                    prompt for an encryption passphrase
      --pem-path string               enter an path to a PEM formatted RSA
                                      key for an encrypted container
  -p, --pid                           run container in a new PID namespace
      --pids-limit int                Limit number of container PIDs, use
                                      -1 for unlimited
      --rocm                          enable experimental Rocm support
  -S, --scratch strings               include a scratch directory within
                                      the container that is linked to a
                                      temporary dir (use -W to force location)
      --security strings              enable security features (SELinux,
                                      Apparmor, Seccomp)
      --sharens                       share the namespace and image with
                                      other containers launched from the
                                      same parent process
      --unsquash                      Convert SIF file to temporary
                                      sandbox before running
  -u, --userns                        run container in a new user namespace
      --uts                           run container in a new UTS namespace
  -W, --workdir string                working directory to be used for
                                      /tmp, /var/tmp and $HOME (if
                                      -c/--contain was also used)
  -w, --writable                      by default all Apptainer containers
                                      are available as read only. This
                                      option makes the file system
                                      accessible as read/write.
      --writable-tmpfs                makes the file system accessible as
                                      read-write with non persistent data
                                      (with overlay support only)


Examples:
  Set the '%test' section with a definition file like so:
  %test
      echo "hello from test" "$@"

  $ apptainer test /tmp/debian.sif command
      hello from test command

  For additional help, please visit our public documentation pages which are
  found at:

      https://apptainer.org/docs/


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_verify

### Tool Description
The verify command allows a user to verify one or more digital signatures within a SIF image.

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Verify digital signature(s) within an image

Usage:
  apptainer verify [verify options...] <image path>

Description:
  The verify command allows a user to verify one or more digital signatures
  within a SIF image.

  Key material can be provided via PEM-encoded file, or via the PGP keyring. To
  manage the PGP keyring, see 'apptainer help key'.

Options:
  -a, --all                                verify all objects
      --certificate string                 path to the certificate
      --certificate-intermediates string   path to pool of intermediate
                                           certificates
      --certificate-roots string           path to pool of root certificates
  -g, --group-id uint32                    verify objects with the
                                           specified group ID
  -h, --help                               help for verify
  -j, --json                               output json
      --key string                         path to the public key file
      --legacy-insecure                    enable verification of
                                           (insecure) legacy signatures
  -l, --local                              only verify with local key(s)
                                           in keyring
      --ocsp-verify                        enable online revocation check
                                           for certificates
  -i, --sif-id uint32                      verify object with the specified ID
  -u, --url string                         specify a URL for a key server


Examples:
  Verify with a public key:
  $ apptainer verify --key public.pem container.sif

  Verify with PGP:
  $ apptainer verify container.sif


For additional help or support, please visit https://apptainer.org/help/
```


## Metadata
- **Skill**: generated
