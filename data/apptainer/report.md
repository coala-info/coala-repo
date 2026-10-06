# apptainer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| apptainer_build | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_cache_list | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_completion | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_delete | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_exec | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_inspect | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_key_import | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_key_list | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_key_newpair | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_key_remove | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_overlay_create | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' (runs only with cwltool --no-match-user), and even then fails because mkfs.ext3 is missing from the image. |
| apptainer_plugin_create | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_pull | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_push | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_run | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_run-help | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_search | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_shell | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_add | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_del | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_dump | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_header | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_info | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_list | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_new | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sif_setprim | Failed | image problem: apptainer 1.3.0 stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_sign | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_test | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |
| apptainer_verify | Failed | image problem: every apptainer 1.3.0 command stops with 'unknown userid 1001' because the container user is not in /etc/passwd; it runs only with cwltool --no-match-user. |

## apptainer_build

### Tool Description
Build an Apptainer image

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
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


## apptainer_cache_list

### Tool Description
List your local Apptainer cache

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
List your local Apptainer cache

Usage:
  apptainer cache list [list options...]

Description:
  This will list your local cache (stored at $HOME/.apptainer/cache if
  APPTAINER_CACHEDIR is not set).

Options:
  -h, --help           help for list
  -T, --type strings   a list of cache types to display, possible entries:
                       library, oci, shub, blob(s), all (default [all])
  -v, --verbose        include cache entries in the output


Examples:
  All group commands have their own help output:

  $ apptainer help cache list
  $ apptainer help cache list --type=library,oci
  $ apptainer cache list --help


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_key_import

### Tool Description
Import a local key into the local or global keyring

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Import a local key into the local or global keyring

Usage:
  apptainer key import [import options...] <input-key>

Description:
  The 'key import' command allows you to add a key to your local or global keyring
  from a specific file.

Options:
  -g, --global           manage global public keys (import/pull/remove are
                         restricted to root user or unprivileged
                         installation only)
  -h, --help             help for import
  -d, --keysdir string   set local keyring dir path, an alternative way is
                         to set environment variable 'APPTAINER_KEYSDIR'
                         (default "/root/.apptainer/keys")
      --new-password     set a new password to the private key


Examples:
  $ apptainer key import ./my-key.asc

  # Import into global keyring (root user only)
  $ apptainer key import --global ./my-key.asc


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_key_list

### Tool Description
List keys in your local or in the global keyring

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
List keys in your local or in the global keyring

Usage:
  apptainer key list

Description:
  List your local keys in your keyring. Will list public (trusted) keys
  by default.

Options:
  -g, --global           manage global public keys (import/pull/remove are
                         restricted to root user or unprivileged
                         installation only)
  -h, --help             help for list
  -d, --keysdir string   set local keyring dir path, an alternative way is
                         to set environment variable 'APPTAINER_KEYSDIR'
                         (default "/root/.apptainer/keys")
  -s, --secret           list private keys instead of the default which
                         displays public ones


Examples:
  $ apptainer key list
  $ apptainer key list --secret

  # list global public keys
  $ apptainer key list --global


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_key_newpair

### Tool Description
Create a new key pair

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Create a new key pair

Usage:
  apptainer key newpair

Description:
  The 'key newpair' command allows you to create a new key or public/private
  keys to be stored in the default user local keyring location (e.g., 
  $HOME/.apptainer/keys).

Options:
  -b, --bit-length int    specify key bit length (default 4096)
  -C, --comment string    key comment
  -E, --email string      key owner email
  -h, --help              help for newpair
  -d, --keysdir string    set local keyring dir path, an alternative way
                          is to set environment variable
                          'APPTAINER_KEYSDIR' (default "/root/.apptainer/keys")
  -N, --name string       key owner name
  -P, --password string   key password
  -U, --push              specify to push the public key to the remote keystore


Examples:
  $ apptainer key newpair
  $ apptainer key newpair --password=psk --name=your-name --comment="key comment" --email=mail@email.com --push=false


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_key_remove

### Tool Description
Remove a local public key from your local or the global keyring

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Remove a local public key from your local or the global keyring

Usage:
  apptainer key remove <fingerprint>

Description:
  The 'key remove' command will remove a local public key from
  the local or the global keyring.

Options:
  -b, --both             remove both public and private keys
  -g, --global           manage global public keys (import/pull/remove are
                         restricted to root user or unprivileged
                         installation only)
  -h, --help             help for remove
  -d, --keysdir string   set local keyring dir path, an alternative way is
                         to set environment variable 'APPTAINER_KEYSDIR'
                         (default "/root/.apptainer/keys")
  -p, --public           remove public keys only
  -s, --secret           remove secret keys only


Examples:
  $ apptainer key remove D87FE3AF5C1F063FCBCC9B02F812842B5EEE5934


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_overlay_create

### Tool Description
Create EXT3 writable overlay image

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Create EXT3 writable overlay image

Usage:
  apptainer overlay create <options> image

Description:
  The overlay create command allows creating EXT3 writable overlay image either
  as a single EXT3 image or by adding it automatically to an existing SIF image.

Options:
      --create-dir strings   directory to create as part of the overlay layout
  -f, --fakeroot             make overlay layout usable by actions run
                             with --fakeroot
  -h, --help                 help for create
  -s, --size int             size of the EXT3 writable overlay in MiB
                             (default 64)
  -S, --sparse               create a sparse overlay


Examples:
  To create and add a writable overlay to an existing SIF image:
  $ apptainer overlay create --size 1024 /tmp/image.sif

  To create a single EXT3 writable overlay image:
  $ apptainer overlay create --size 1024 /tmp/my_overlay.img

  To create a sparse overlay when creating a new ext3 file system image:
  $ apptainer overlay create --size 1024 --sparse /tmp/ext3_overlay.img

  To create an EXT3 writable overlay image for use with --fakeroot actions:
  $ apptainer overlay create --fakeroot --size 1024 /tmp/my_overlay.img


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_plugin_create

### Tool Description
Create a plugin skeleton directory

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Create a plugin skeleton directory

Usage:
  apptainer plugin create <host_path> <name>

Description:
  The 'plugin create' command allows a user to creates a plugin skeleton directory
  structure to start development of a new plugin.

Options:
  -h, --help   help for create


Examples:
  $ apptainer plugin create ~/myplugin github.com/username/myplugin
  $ ls -1 ~/myplugin
  go.mod
  main.go
  apptainer_source
  


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_add

### Tool Description
Add data object

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Add data object

Usage:
  apptainer sif add <sif_path> <object_path> [flags]

Description:Add a data object to a SIF image.

Options:
      --alignment int       set alignment [default: 4096 with --datatype
                            4-Partition, 0 otherwise]
      --datatype int        the type of data to add
                            [NEEDED, no default]:
                              1-Deffile,        2-EnvVar,        3-Labels,
                              4-Partition,      5-Signature,    
                            6-GenericJSON,
                              7-Generic,        8-CryptoMessage, 9-SBOM,
                              10-OCI.RootIndex, 11-OCI.Blob
      --filename string     set logical filename/handle [default: input
                            filename]
      --groupid uint32      set groupid [default: 0]
  -h, --help                help for add
      --link uint32         set link pointer [default: 0]
      --partarch int32      the main architecture used (with --datatype
                            4-Partition)
                            [NEEDED, no default]:
                              1-386,       2-amd64,     3-arm,
                              4-arm64,     5-ppc64,     6-ppc64le,
                              7-mips,      8-mipsle,    9-mips64,
                              10-mips64le, 11-s390x,    12-riscv64
      --partfs int32        the filesystem used (with --datatype
                            4-Partition)
                            [NEEDED, no default]:
                              1-Squash,    2-Ext3,      3-ImmuObj,
                              4-Raw
      --parttype int32      the type of partition (with --datatype
                            4-Partition)
                            [NEEDED, no default]:
                              1-System,    2-PrimSys,   3-Data,
                              4-Overlay
      --sbomformat string   the SBOM format (with --datatype 9-sbom):
                              cyclonedx-json, cyclonedx-xml,  github-json,
                              spdx-json,      spdx-rdf,      
                            spdx-tag-value,
                              spdx-yaml,      syft-json
      --signentity string   the entity that signs (with --datatype
                            5-Signature)
                            [NEEDED, no default]:
                              example: 433FE984155206BD962725E20E8713472A879943
      --signhash int32      the signature hash used (with --datatype
                            5-Signature)
                            [NEEDED, no default]:
                              1-SHA256,      2-SHA384,      3-SHA512,
                              4-BLAKE2s_256, 5-BLAKE2b_256


Examples:sif add image.sif recipe.def --datatype 1
sif add image.sif rootfs.squashfs --datatype 4 --parttype 1 --partfs 1 --partarch 2
sif add image.sif signature.bin --datatype 5 --signentity 433FE984155206BD962725E20E8713472A879943 --signhash 1


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_del

### Tool Description
Delete data object

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Delete data object

Usage:
  apptainer sif del <id> <sif_path>

Description:Delete a data object from a SIF image.

Options:
  -h, --help   help for del


Examples:sif del 1 image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_dump

### Tool Description
Dump data object

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Dump data object

Usage:
  apptainer sif dump <id> <sif_path>

Description:Dump a data object from a SIF image.

Options:
  -h, --help   help for dump


Examples:sif dump 1 image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_header

### Tool Description
Display global header

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Display global header

Usage:
  apptainer sif header <sif_path>

Description:Display global header from a SIF image.

Options:
  -h, --help   help for header


Examples:sif header image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_info

### Tool Description
Display data object info

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Display data object info

Usage:
  apptainer sif info <id> <sif_path>

Description:Display info about a data object from a SIF image.

Options:
  -h, --help   help for info


Examples:sif info 1 image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_list

### Tool Description
List data objects

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
List data objects

Usage:
  apptainer sif list <sif_path>

Description:List data objects from a SIF image.

Options:
  -h, --help   help for list


Examples:sif list image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_new

### Tool Description
Create SIF image

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Create SIF image

Usage:
  apptainer sif new <sif_path>

Description:Create a new, empty SIF image.

Options:
  -h, --help   help for new


Examples:sif new image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## apptainer_sif_setprim

### Tool Description
Set primary system partition

### Metadata
- **Docker Image**: quay.io/biocontainers/apptainer:latest
- **Homepage**: https://github.com/apptainer/apptainer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/apptainer/overview
- **Total Downloads**: 127.6K
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/apptainer/apptainer
- **Stars**: N/A
### Original Help Text
```text
Set primary system partition

Usage:
  apptainer sif setprim <id> <sif_path>

Description:Set the primary system partition in a SIF image.

Options:
  -h, --help   help for setprim


Examples:sif setprim 1 image.sif


For additional help or support, please visit https://apptainer.org/help/
```


## Metadata
- **Skill**: generated
