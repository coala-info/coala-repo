cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - test
label: apptainer_test
doc: "Run the user-defined tests within a container\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image_path
    type: File
    doc: Path to the container image
    inputBinding:
      position: 1
  - id: add_caps
    type:
      - 'null'
      - string
    doc: a comma separated capability list to add
    inputBinding:
      position: 102
      prefix: --add-caps
  - id: allow_setuid
    type:
      - 'null'
      - boolean
    doc: allow setuid binaries in container (root only)
    inputBinding:
      position: 102
      prefix: --allow-setuid
  - id: app
    type:
      - 'null'
      - string
    doc: set an application to run inside a container
    inputBinding:
      position: 102
      prefix: --app
  - id: apply_cgroups
    type:
      - 'null'
      - File
    doc: apply cgroups from file for container processes (root only)
    inputBinding:
      position: 102
      prefix: --apply-cgroups
  - id: bind
    type:
      - 'null'
      - type: array
        items: string
    doc: a user-bind path specification. spec has the format src[:dest[:opts]]
    inputBinding:
      position: 102
      prefix: --bind
  - id: blkio_weight
    type:
      - 'null'
      - int
    doc: Block IO relative weight in range 10-1000, 0 to disable
    inputBinding:
      position: 102
      prefix: --blkio-weight
  - id: blkio_weight_device
    type:
      - 'null'
      - type: array
        items: string
    doc: Device specific block IO relative weight
    inputBinding:
      position: 102
      prefix: --blkio-weight-device
  - id: cleanenv
    type:
      - 'null'
      - boolean
    doc: clean environment before running container
    inputBinding:
      position: 102
      prefix: --cleanenv
  - id: compat
    type:
      - 'null'
      - boolean
    doc: apply settings for increased OCI/Docker compatibility. Infers --containall,
      --no-init, --no-umask, --no-eval, --writable-tmpfs.
    inputBinding:
      position: 102
      prefix: --compat
  - id: contain
    type:
      - 'null'
      - boolean
    doc: use minimal /dev and empty other directories (e.g. /tmp and $HOME) instead
      of sharing filesystems from your host
    inputBinding:
      position: 102
      prefix: --contain
  - id: containall
    type:
      - 'null'
      - boolean
    doc: contain not only file systems, but also PID, IPC, and environment
    inputBinding:
      position: 102
      prefix: --containall
  - id: cpu_shares
    type:
      - 'null'
      - int
    doc: CPU shares for container
    default: -1
    inputBinding:
      position: 102
      prefix: --cpu-shares
  - id: cpus
    type:
      - 'null'
      - string
    doc: Number of CPUs available to container
    inputBinding:
      position: 102
      prefix: --cpus
  - id: cpuset_cpus
    type:
      - 'null'
      - string
    doc: List of host CPUs available to container
    inputBinding:
      position: 102
      prefix: --cpuset-cpus
  - id: cpuset_mems
    type:
      - 'null'
      - string
    doc: List of host memory nodes available to container
    inputBinding:
      position: 102
      prefix: --cpuset-mems
  - id: cwd
    type:
      - 'null'
      - string
    doc: initial working directory for payload process inside the container (synonym
      for --pwd)
    inputBinding:
      position: 102
      prefix: --cwd
  - id: disable_cache
    type:
      - 'null'
      - boolean
    doc: do not use or create cache
    inputBinding:
      position: 102
      prefix: --disable-cache
  - id: dns
    type:
      - 'null'
      - string
    doc: list of DNS server separated by commas to add in resolv.conf
    inputBinding:
      position: 102
      prefix: --dns
  - id: docker_host
    type:
      - 'null'
      - string
    doc: specify a custom Docker daemon host
    inputBinding:
      position: 102
      prefix: --docker-host
  - id: docker_login
    type:
      - 'null'
      - boolean
    doc: login to a Docker Repository interactively
    inputBinding:
      position: 102
      prefix: --docker-login
  - id: drop_caps
    type:
      - 'null'
      - string
    doc: a comma separated capability list to drop
    inputBinding:
      position: 102
      prefix: --drop-caps
  - id: env
    type:
      - 'null'
      - type: array
        items: string
    doc: pass environment variable to contained process
    inputBinding:
      position: 102
      prefix: --env
  - id: env_file
    type:
      - 'null'
      - File
    doc: pass environment variables from file to contained process
    inputBinding:
      position: 102
      prefix: --env-file
  - id: fakeroot
    type:
      - 'null'
      - boolean
    doc: run container with the appearance of running as root
    inputBinding:
      position: 102
      prefix: --fakeroot
  - id: fusemount
    type:
      - 'null'
      - type: array
        items: string
    doc: A FUSE filesystem mount specification
    inputBinding:
      position: 102
      prefix: --fusemount
  - id: home
    type:
      - 'null'
      - string
    doc: a home directory specification
    inputBinding:
      position: 102
      prefix: --home
  - id: hostname
    type:
      - 'null'
      - string
    doc: set container hostname
    inputBinding:
      position: 102
      prefix: --hostname
  - id: ipc
    type:
      - 'null'
      - boolean
    doc: run container in a new IPC namespace
    inputBinding:
      position: 102
      prefix: --ipc
  - id: keep_privs
    type:
      - 'null'
      - boolean
    doc: let root user keep privileges in container (root only)
    inputBinding:
      position: 102
      prefix: --keep-privs
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory limit in bytes
    inputBinding:
      position: 102
      prefix: --memory
  - id: memory_reservation
    type:
      - 'null'
      - string
    doc: Memory soft limit in bytes
    inputBinding:
      position: 102
      prefix: --memory-reservation
  - id: memory_swap
    type:
      - 'null'
      - string
    doc: Swap limit, use -1 for unlimited swap
    inputBinding:
      position: 102
      prefix: --memory-swap
  - id: mount
    type:
      - 'null'
      - type: array
        items: string
    doc: a mount specification e.g. 'type=bind,source=/opt,destination=/hostopt'
    inputBinding:
      position: 102
      prefix: --mount
  - id: net
    type:
      - 'null'
      - boolean
    doc: run container in a new network namespace
    inputBinding:
      position: 102
      prefix: --net
  - id: network
    type:
      - 'null'
      - string
    doc: specify desired network type separated by commas
    inputBinding:
      position: 102
      prefix: --network
  - id: network_args
    type:
      - 'null'
      - type: array
        items: string
    doc: specify network arguments to pass to CNI plugins
    inputBinding:
      position: 102
      prefix: --network-args
  - id: no_eval
    type:
      - 'null'
      - boolean
    doc: do not shell evaluate env vars or OCI container CMD/ENTRYPOINT/ARGS
    inputBinding:
      position: 102
      prefix: --no-eval
  - id: no_home
    type:
      - 'null'
      - boolean
    doc: do NOT mount users home directory if /home is not the current working directory
    inputBinding:
      position: 102
      prefix: --no-home
  - id: no_https
    type:
      - 'null'
      - boolean
    doc: use http instead of https for docker:// oras:// and library://<hostname>/...
      URIs
    inputBinding:
      position: 102
      prefix: --no-https
  - id: no_init
    type:
      - 'null'
      - boolean
    doc: do NOT start shim process with --pid
    inputBinding:
      position: 102
      prefix: --no-init
  - id: no_mount
    type:
      - 'null'
      - type: array
        items: string
    doc: disable one or more 'mount xxx' options set in apptainer.conf
    inputBinding:
      position: 102
      prefix: --no-mount
  - id: no_pid
    type:
      - 'null'
      - boolean
    doc: do not run container in a new PID namespace
    inputBinding:
      position: 102
      prefix: --no-pid
  - id: no_privs
    type:
      - 'null'
      - boolean
    doc: drop all privileges from root user in container
    inputBinding:
      position: 102
      prefix: --no-privs
  - id: no_umask
    type:
      - 'null'
      - boolean
    doc: do not propagate umask to the container, set default 0022 umask
    inputBinding:
      position: 102
      prefix: --no-umask
  - id: nv
    type:
      - 'null'
      - boolean
    doc: enable Nvidia support
    inputBinding:
      position: 102
      prefix: --nv
  - id: nvccli
    type:
      - 'null'
      - boolean
    doc: use nvidia-container-cli for GPU setup (experimental)
    inputBinding:
      position: 102
      prefix: --nvccli
  - id: oom_kill_disable
    type:
      - 'null'
      - boolean
    doc: Disable OOM killer
    inputBinding:
      position: 102
      prefix: --oom-kill-disable
  - id: overlay
    type:
      - 'null'
      - type: array
        items: string
    doc: use an overlayFS image for persistent data storage or as read-only layer
      of container
    inputBinding:
      position: 102
      prefix: --overlay
  - id: passphrase
    type:
      - 'null'
      - boolean
    doc: prompt for an encryption passphrase
    inputBinding:
      position: 102
      prefix: --passphrase
  - id: pem_path
    type:
      - 'null'
      - File
    doc: enter an path to a PEM formatted RSA key for an encrypted container
    inputBinding:
      position: 102
      prefix: --pem-path
  - id: pid
    type:
      - 'null'
      - boolean
    doc: run container in a new PID namespace
    inputBinding:
      position: 102
      prefix: --pid
  - id: pids_limit
    type:
      - 'null'
      - int
    doc: Limit number of container PIDs, use -1 for unlimited
    inputBinding:
      position: 102
      prefix: --pids-limit
  - id: rocm
    type:
      - 'null'
      - boolean
    doc: enable experimental Rocm support
    inputBinding:
      position: 102
      prefix: --rocm
  - id: scratch
    type:
      - 'null'
      - type: array
        items: string
    doc: include a scratch directory within the container that is linked to a temporary
      dir
    inputBinding:
      position: 102
      prefix: --scratch
  - id: security
    type:
      - 'null'
      - type: array
        items: string
    doc: enable security features (SELinux, Apparmor, Seccomp)
    inputBinding:
      position: 102
      prefix: --security
  - id: sharens
    type:
      - 'null'
      - boolean
    doc: share the namespace and image with other containers launched from the same
      parent process
    inputBinding:
      position: 102
      prefix: --sharens
  - id: unsquash
    type:
      - 'null'
      - boolean
    doc: Convert SIF file to temporary sandbox before running
    inputBinding:
      position: 102
      prefix: --unsquash
  - id: userns
    type:
      - 'null'
      - boolean
    doc: run container in a new user namespace
    inputBinding:
      position: 102
      prefix: --userns
  - id: uts
    type:
      - 'null'
      - boolean
    doc: run container in a new UTS namespace
    inputBinding:
      position: 102
      prefix: --uts
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: working directory to be used for /tmp, /var/tmp and $HOME
    inputBinding:
      position: 102
      prefix: --workdir
  - id: writable
    type:
      - 'null'
      - boolean
    doc: by default all Apptainer containers are available as read only. This option
      makes the file system accessible as read/write.
    inputBinding:
      position: 102
      prefix: --writable
  - id: writable_tmpfs
    type:
      - 'null'
      - boolean
    doc: makes the file system accessible as read-write with non persistent data (with
      overlay support only)
    inputBinding:
      position: 102
      prefix: --writable-tmpfs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_test.out
