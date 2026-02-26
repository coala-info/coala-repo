cwlVersion: v1.2
class: CommandLineTool
baseCommand: stress-ng
label: stress-ng
doc: "Stress test the system's CPU, memory, I/O, and other subsystems.\n\nTool homepage:
  https://github.com/ColinIanKing/stress-ng"
inputs:
  - id: abort
    type:
      - 'null'
      - boolean
    doc: abort all stressors if any stressor fails
    inputBinding:
      position: 101
      prefix: --abort
  - id: access
    type:
      - 'null'
      - int
    doc: start N workers that stress file access permissions
    inputBinding:
      position: 101
      prefix: --access
  - id: access_ops
    type:
      - 'null'
      - int
    doc: stop after N file access bogo operations
    inputBinding:
      position: 101
      prefix: --access-ops
  - id: af_alg
    type:
      - 'null'
      - int
    doc: start N workers that stress AF_ALG socket domain
    inputBinding:
      position: 101
      prefix: --af-alg
  - id: af_alg_dump
    type:
      - 'null'
      - boolean
    doc: dump internal list from /proc/crypto to stdout
    inputBinding:
      position: 101
      prefix: --af-alg-dump
  - id: af_alg_ops
    type:
      - 'null'
      - int
    doc: stop after N af-alg bogo operations
    inputBinding:
      position: 101
      prefix: --af-alg-ops
  - id: affinity
    type:
      - 'null'
      - int
    doc: start N workers that rapidly change CPU affinity
    inputBinding:
      position: 101
      prefix: --affinity
  - id: affinity_ops
    type:
      - 'null'
      - int
    doc: stop after N affinity bogo operations
    inputBinding:
      position: 101
      prefix: --affinity-ops
  - id: affinity_rand
    type:
      - 'null'
      - boolean
    doc: change affinity randomly rather than sequentially
    inputBinding:
      position: 101
      prefix: --affinity-rand
  - id: aggressive
    type:
      - 'null'
      - boolean
    doc: enable all aggressive options
    inputBinding:
      position: 101
      prefix: --aggressive
  - id: aio
    type:
      - 'null'
      - int
    doc: start N workers that issue async I/O requests
    inputBinding:
      position: 101
      prefix: --aio
  - id: aio_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo async I/O requests
    inputBinding:
      position: 101
      prefix: --aio-ops
  - id: aio_requests
    type:
      - 'null'
      - int
    doc: number of async I/O requests per worker
    inputBinding:
      position: 101
      prefix: --aio-requests
  - id: aiol
    type:
      - 'null'
      - int
    doc: start N workers that exercise Linux async I/O
    inputBinding:
      position: 101
      prefix: --aiol
  - id: aiol_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo Linux aio async I/O requests
    inputBinding:
      position: 101
      prefix: --aiol-ops
  - id: aiol_requests
    type:
      - 'null'
      - int
    doc: number of Linux aio async I/O requests per worker
    inputBinding:
      position: 101
      prefix: --aiol-requests
  - id: all
    type:
      - 'null'
      - int
    doc: start N workers of each stress test
    inputBinding:
      position: 101
      prefix: --all
  - id: apparmor
    type:
      - 'null'
      - int
    doc: start N workers exercising AppArmor interfaces
    inputBinding:
      position: 101
      prefix: --apparmor
  - id: apparmor_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo AppArmor worker bogo operations
    inputBinding:
      position: 101
      prefix: --apparmor-ops
  - id: atomic
    type:
      - 'null'
      - int
    doc: start N workers exercising GCC atomic operations
    inputBinding:
      position: 101
      prefix: --atomic
  - id: atomic_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo atomic bogo operations
    inputBinding:
      position: 101
      prefix: --atomic-ops
  - id: backoff
    type:
      - 'null'
      - int
    doc: wait of N microseconds before work starts
    inputBinding:
      position: 101
      prefix: --backoff
  - id: bad_altstack
    type:
      - 'null'
      - int
    doc: start N workers exercising bad signal stacks
    inputBinding:
      position: 101
      prefix: --bad-altstack
  - id: bad_altstack_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo signal stack SIGSEGVs
    inputBinding:
      position: 101
      prefix: --bad-altstack-ops
  - id: bad_ioctl
    type:
      - 'null'
      - int
    doc: start N stressors that perform illegal read ioctls on devices
    inputBinding:
      position: 101
      prefix: --bad-ioctl
  - id: bad_ioctl_ops
    type:
      - 'null'
      - int
    doc: stop after N bad ioctl bogo operations
    inputBinding:
      position: 101
      prefix: --bad-ioctl-ops
  - id: bigheap
    type:
      - 'null'
      - int
    doc: start N workers that grow the heap using calloc()
    inputBinding:
      position: 101
      prefix: --bigheap
  - id: bigheap_growth
    type:
      - 'null'
      - int
    doc: grow heap by N bytes per iteration
    inputBinding:
      position: 101
      prefix: --bigheap-growth
  - id: bigheap_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo bigheap operations
    inputBinding:
      position: 101
      prefix: --bigheap-ops
  - id: bind_mount
    type:
      - 'null'
      - int
    doc: start N workers exercising bind mounts
    inputBinding:
      position: 101
      prefix: --bind-mount
  - id: bind_mount_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo bind mount operations
    inputBinding:
      position: 101
      prefix: --bind-mount-ops
  - id: binderfs
    type:
      - 'null'
      - int
    doc: start N workers exercising binderfs
    inputBinding:
      position: 101
      prefix: --binderfs
  - id: binderfs_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo binderfs operations
    inputBinding:
      position: 101
      prefix: --binderfs-ops
  - id: branch
    type:
      - 'null'
      - int
    doc: start N workers that force branch misprediction
    inputBinding:
      position: 101
      prefix: --branch
  - id: branch_ops
    type:
      - 'null'
      - int
    doc: stop after N branch misprediction branches
    inputBinding:
      position: 101
      prefix: --branch-ops
  - id: brk
    type:
      - 'null'
      - int
    doc: start N workers performing rapid brk calls
    inputBinding:
      position: 101
      prefix: --brk
  - id: brk_mlock
    type:
      - 'null'
      - boolean
    doc: attempt to mlock newly mapped brk pages
    inputBinding:
      position: 101
      prefix: --brk-mlock
  - id: brk_notouch
    type:
      - 'null'
      - boolean
    doc: don't touch (page in) new data segment page
    inputBinding:
      position: 101
      prefix: --brk-notouch
  - id: brk_ops
    type:
      - 'null'
      - int
    doc: stop after N brk bogo operations
    inputBinding:
      position: 101
      prefix: --brk-ops
  - id: bsearch
    type:
      - 'null'
      - int
    doc: start N workers that exercise a binary search
    inputBinding:
      position: 101
      prefix: --bsearch
  - id: bsearch_ops
    type:
      - 'null'
      - int
    doc: stop after N binary search bogo operations
    inputBinding:
      position: 101
      prefix: --bsearch-ops
  - id: bsearch_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to bsearch
    inputBinding:
      position: 101
      prefix: --bsearch-size
  - id: cache
    type:
      - 'null'
      - int
    doc: start N CPU cache thrashing workers
    inputBinding:
      position: 101
      prefix: --cache
  - id: cache_fence
    type:
      - 'null'
      - boolean
    doc: serialize stores
    inputBinding:
      position: 101
      prefix: --cache-fence
  - id: cache_flush
    type:
      - 'null'
      - boolean
    doc: flush cache after every memory write (x86 only)
    inputBinding:
      position: 101
      prefix: --cache-flush
  - id: cache_level
    type:
      - 'null'
      - int
    doc: only exercise specified cache
    inputBinding:
      position: 101
      prefix: --cache-level
  - id: cache_no_affinity
    type:
      - 'null'
      - boolean
    doc: do not change CPU affinity
    inputBinding:
      position: 101
      prefix: --cache-no-affinity
  - id: cache_ops
    type:
      - 'null'
      - int
    doc: stop after N cache bogo operations
    inputBinding:
      position: 101
      prefix: --cache-ops
  - id: cache_prefetch
    type:
      - 'null'
      - boolean
    doc: prefetch on memory reads/writes
    inputBinding:
      position: 101
      prefix: --cache-prefetch
  - id: cache_sfence
    type:
      - 'null'
      - boolean
    doc: serialize stores with sfence
    inputBinding:
      position: 101
      prefix: --cache-sfence
  - id: cache_ways
    type:
      - 'null'
      - int
    doc: only fill specified number of cache ways
    inputBinding:
      position: 101
      prefix: --cache-ways
  - id: cap
    type:
      - 'null'
      - int
    doc: start N workers exercising capget
    inputBinding:
      position: 101
      prefix: --cap
  - id: cap_ops
    type:
      - 'null'
      - int
    doc: stop cap workers after N bogo capget operations
    inputBinding:
      position: 101
      prefix: --cap-ops
  - id: chattr
    type:
      - 'null'
      - int
    doc: start N workers thrashing chattr file mode bits
    inputBinding:
      position: 101
      prefix: --chattr
  - id: chattr_ops
    type:
      - 'null'
      - int
    doc: stop chattr workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --chattr-ops
  - id: chdir
    type:
      - 'null'
      - int
    doc: start N workers thrashing chdir on many paths
    inputBinding:
      position: 101
      prefix: --chdir
  - id: chdir_dirs
    type:
      - 'null'
      - int
    doc: select number of directories to exercise chdir on
    inputBinding:
      position: 101
      prefix: --chdir-dirs
  - id: chdir_ops
    type:
      - 'null'
      - int
    doc: stop chdir workers after N bogo chdir operations
    inputBinding:
      position: 101
      prefix: --chdir-ops
  - id: chmod
    type:
      - 'null'
      - int
    doc: start N workers thrashing chmod file mode bits
    inputBinding:
      position: 101
      prefix: --chmod
  - id: chmod_ops
    type:
      - 'null'
      - int
    doc: stop chmod workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --chmod-ops
  - id: chown
    type:
      - 'null'
      - int
    doc: start N workers thrashing chown file ownership
    inputBinding:
      position: 101
      prefix: --chown
  - id: chown_ops
    type:
      - 'null'
      - int
    doc: stop chown workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --chown-ops
  - id: chroot
    type:
      - 'null'
      - int
    doc: start N workers thrashing chroot
    inputBinding:
      position: 101
      prefix: --chroot
  - id: chroot_ops
    type:
      - 'null'
      - int
    doc: stop chhroot workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --chroot-ops
  - id: class
    type:
      - 'null'
      - string
    doc: specify a class of stressors, use with --sequential
    inputBinding:
      position: 101
      prefix: --class
  - id: clock
    type:
      - 'null'
      - int
    doc: start N workers thrashing clocks and POSIX timers
    inputBinding:
      position: 101
      prefix: --clock
  - id: clock_ops
    type:
      - 'null'
      - int
    doc: stop clock workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --clock-ops
  - id: clone
    type:
      - 'null'
      - int
    doc: start N workers that rapidly create and reap clones
    inputBinding:
      position: 101
      prefix: --clone
  - id: clone_max
    type:
      - 'null'
      - int
    doc: set upper limit of N clones per worker
    inputBinding:
      position: 101
      prefix: --clone-max
  - id: clone_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo clone operations
    inputBinding:
      position: 101
      prefix: --clone-ops
  - id: close
    type:
      - 'null'
      - int
    doc: start N workers that exercise races on close
    inputBinding:
      position: 101
      prefix: --close
  - id: close_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo close operations
    inputBinding:
      position: 101
      prefix: --close-ops
  - id: context
    type:
      - 'null'
      - int
    doc: start N workers exercising user context
    inputBinding:
      position: 101
      prefix: --context
  - id: context_ops
    type:
      - 'null'
      - int
    doc: stop context workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --context-ops
  - id: copy_file
    type:
      - 'null'
      - int
    doc: start N workers that copy file data
    inputBinding:
      position: 101
      prefix: --copy-file
  - id: copy_file_bytes
    type:
      - 'null'
      - int
    doc: specify size of file to be copied
    inputBinding:
      position: 101
      prefix: --copy-file-bytes
  - id: copy_file_ops
    type:
      - 'null'
      - int
    doc: stop after N copy bogo operations
    inputBinding:
      position: 101
      prefix: --copy-file-ops
  - id: cpu
    type:
      - 'null'
      - int
    doc: start N workers spinning on sqrt(rand())
    inputBinding:
      position: 101
      prefix: --cpu
  - id: cpu_load
    type:
      - 'null'
      - string
    doc: load CPU by P %, 0=sleep, 100=full load (see -c)
    inputBinding:
      position: 101
      prefix: --cpu-load
  - id: cpu_load_slice
    type:
      - 'null'
      - string
    doc: specify time slice during busy load
    inputBinding:
      position: 101
      prefix: --cpu-load-slice
  - id: cpu_method
    type:
      - 'null'
      - string
    doc: specify stress cpu method M, default is all
    inputBinding:
      position: 101
      prefix: --cpu-method
  - id: cpu_online
    type:
      - 'null'
      - int
    doc: start N workers offlining/onlining the CPUs
    inputBinding:
      position: 101
      prefix: --cpu-online
  - id: cpu_online_ops
    type:
      - 'null'
      - int
    doc: stop after N offline/online operations
    inputBinding:
      position: 101
      prefix: --cpu-online-ops
  - id: cpu_ops
    type:
      - 'null'
      - int
    doc: stop after N cpu bogo operations
    inputBinding:
      position: 101
      prefix: --cpu-ops
  - id: crypt
    type:
      - 'null'
      - int
    doc: start N workers performing password encryption
    inputBinding:
      position: 101
      prefix: --crypt
  - id: crypt_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo crypt operations
    inputBinding:
      position: 101
      prefix: --crypt-ops
  - id: cyclic
    type:
      - 'null'
      - int
    doc: start N cyclic real time benchmark stressors
    inputBinding:
      position: 101
      prefix: --cyclic
  - id: cyclic_dist
    type:
      - 'null'
      - int
    doc: calculate distribution of interval N nanosecs
    inputBinding:
      position: 101
      prefix: --cyclic-dist
  - id: cyclic_method
    type:
      - 'null'
      - string
    doc: specify cyclic method M, default is clock_ns
    inputBinding:
      position: 101
      prefix: --cyclic-method
  - id: cyclic_ops
    type:
      - 'null'
      - int
    doc: stop after N cyclic timing cycles
    inputBinding:
      position: 101
      prefix: --cyclic-ops
  - id: cyclic_policy
    type:
      - 'null'
      - string
    doc: used rr or fifo scheduling policy
    inputBinding:
      position: 101
      prefix: --cyclic-policy
  - id: cyclic_prio
    type:
      - 'null'
      - int
    doc: real time scheduling priority 1..100
    inputBinding:
      position: 101
      prefix: --cyclic-prio
  - id: cyclic_sleep
    type:
      - 'null'
      - int
    doc: sleep time of real time timer in nanosecs
    inputBinding:
      position: 101
      prefix: --cyclic-sleep
  - id: daemon
    type:
      - 'null'
      - int
    doc: start N workers creating multiple daemons
    inputBinding:
      position: 101
      prefix: --daemon
  - id: daemon_ops
    type:
      - 'null'
      - int
    doc: stop when N daemons have been created
    inputBinding:
      position: 101
      prefix: --daemon-ops
  - id: dccp
    type:
      - 'null'
      - int
    doc: start N workers exercising network DCCP I/O
    inputBinding:
      position: 101
      prefix: --dccp
  - id: dccp_domain
    type:
      - 'null'
      - string
    doc: specify DCCP domain, default is ipv4
    inputBinding:
      position: 101
      prefix: --dccp-domain
  - id: dccp_ops
    type:
      - 'null'
      - int
    doc: stop after N DCCP bogo operations
    inputBinding:
      position: 101
      prefix: --dccp-ops
  - id: dccp_opts
    type:
      - 'null'
      - string
    doc: DCCP data send options [send|sendmsg|sendmmsg]
    inputBinding:
      position: 101
      prefix: --dccp-opts
  - id: dccp_port
    type:
      - 'null'
      - int
    doc: use DCCP ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --dccp-port
  - id: dentries
    type:
      - 'null'
      - int
    doc: create N dentries per iteration
    inputBinding:
      position: 101
      prefix: --dentries
  - id: dentry
    type:
      - 'null'
      - int
    doc: start N dentry thrashing stressors
    inputBinding:
      position: 101
      prefix: --dentry
  - id: dentry_ops
    type:
      - 'null'
      - int
    doc: stop after N dentry bogo operations
    inputBinding:
      position: 101
      prefix: --dentry-ops
  - id: dentry_order
    type:
      - 'null'
      - string
    doc: specify unlink order (reverse, forward, stride)
    inputBinding:
      position: 101
      prefix: --dentry-order
  - id: dev
    type:
      - 'null'
      - int
    doc: start N device entry thrashing stressors
    inputBinding:
      position: 101
      prefix: --dev
  - id: dev_file
    type:
      - 'null'
      - File
    doc: specify the /dev/ file to exercise
    inputBinding:
      position: 101
      prefix: --dev-file
  - id: dev_ops
    type:
      - 'null'
      - int
    doc: stop after N device thrashing bogo ops
    inputBinding:
      position: 101
      prefix: --dev-ops
  - id: dev_shm
    type:
      - 'null'
      - int
    doc: start N /dev/shm file and mmap stressors
    inputBinding:
      position: 101
      prefix: --dev-shm
  - id: dev_shm_ops
    type:
      - 'null'
      - int
    doc: stop after N /dev/shm bogo ops
    inputBinding:
      position: 101
      prefix: --dev-shm-ops
  - id: dir
    type:
      - 'null'
      - int
    doc: start N directory thrashing stressors
    inputBinding:
      position: 101
      prefix: --dir
  - id: dir_dirs
    type:
      - 'null'
      - int
    doc: select number of directories to exercise dir on
    inputBinding:
      position: 101
      prefix: --dir-dirs
  - id: dir_ops
    type:
      - 'null'
      - int
    doc: stop after N directory bogo operations
    inputBinding:
      position: 101
      prefix: --dir-ops
  - id: dirdeep
    type:
      - 'null'
      - int
    doc: start N directory depth stressors
    inputBinding:
      position: 101
      prefix: --dirdeep
  - id: dirdeep_dirs
    type:
      - 'null'
      - int
    doc: create N directories per level
    inputBinding:
      position: 101
      prefix: --dirdeep-dirs
  - id: dirdeep_ops
    type:
      - 'null'
      - int
    doc: stop after N directory depth bogo operations
    inputBinding:
      position: 101
      prefix: --dirdeep-ops
  - id: dnotify
    type:
      - 'null'
      - int
    doc: start N workers exercising dnotify events
    inputBinding:
      position: 101
      prefix: --dnotify
  - id: dnotify_ops
    type:
      - 'null'
      - int
    doc: stop dnotify workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --dnotify-ops
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: do not run
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: dup
    type:
      - 'null'
      - int
    doc: start N workers exercising dup/close
    inputBinding:
      position: 101
      prefix: --dup
  - id: dup_ops
    type:
      - 'null'
      - int
    doc: stop after N dup/close bogo operations
    inputBinding:
      position: 101
      prefix: --dup-ops
  - id: dynlib
    type:
      - 'null'
      - int
    doc: start N workers exercising dlopen/dlclose
    inputBinding:
      position: 101
      prefix: --dynlib
  - id: dynlib_ops
    type:
      - 'null'
      - int
    doc: stop after N dlopen/dlclose bogo operations
    inputBinding:
      position: 101
      prefix: --dynlib-ops
  - id: efivar
    type:
      - 'null'
      - int
    doc: start N workers that read EFI variables
    inputBinding:
      position: 101
      prefix: --efivar
  - id: efivar_ops
    type:
      - 'null'
      - int
    doc: stop after N EFI variable bogo read operations
    inputBinding:
      position: 101
      prefix: --efivar-ops
  - id: enosys
    type:
      - 'null'
      - int
    doc: start N workers that call non-existent system calls
    inputBinding:
      position: 101
      prefix: --enosys
  - id: enosys_ops
    type:
      - 'null'
      - int
    doc: stop after N enosys bogo operations
    inputBinding:
      position: 101
      prefix: --enosys-ops
  - id: env
    type:
      - 'null'
      - int
    doc: start N workers setting environment vars
    inputBinding:
      position: 101
      prefix: --env
  - id: env_ops
    type:
      - 'null'
      - int
    doc: stop after N env bogo operations
    inputBinding:
      position: 101
      prefix: --env-ops
  - id: epoll
    type:
      - 'null'
      - int
    doc: start N workers doing epoll handled socket activity
    inputBinding:
      position: 101
      prefix: --epoll
  - id: epoll_domain
    type:
      - 'null'
      - string
    doc: specify socket domain, default is unix
    inputBinding:
      position: 101
      prefix: --epoll-domain
  - id: epoll_ops
    type:
      - 'null'
      - int
    doc: stop after N epoll bogo operations
    inputBinding:
      position: 101
      prefix: --epoll-ops
  - id: epoll_port
    type:
      - 'null'
      - int
    doc: use socket ports P upwards
    inputBinding:
      position: 101
      prefix: --epoll-port
  - id: eventfd
    type:
      - 'null'
      - int
    doc: start N workers stressing eventfd read/writes
    inputBinding:
      position: 101
      prefix: --eventfd
  - id: eventfd_ops
    type:
      - 'null'
      - int
    doc: stop eventfd workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --eventfd-ops
  - id: eventfs_nonblock
    type:
      - 'null'
      - boolean
    doc: poll with non-blocking I/O on eventfd fd
    inputBinding:
      position: 101
      prefix: --eventfs-nonblock
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: list of stressors to exclude (not run)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: exec
    type:
      - 'null'
      - int
    doc: start N workers spinning on fork() and exec()
    inputBinding:
      position: 101
      prefix: --exec
  - id: exec_max
    type:
      - 'null'
      - int
    doc: create P workers per iteration, default is 1
    inputBinding:
      position: 101
      prefix: --exec-max
  - id: exec_ops
    type:
      - 'null'
      - int
    doc: stop after N exec bogo operations
    inputBinding:
      position: 101
      prefix: --exec-ops
  - id: fallocate
    type:
      - 'null'
      - int
    doc: start N workers fallocating 16MB files
    inputBinding:
      position: 101
      prefix: --fallocate
  - id: fallocate_bytes
    type:
      - 'null'
      - int
    doc: specify size of file to allocate
    inputBinding:
      position: 101
      prefix: --fallocate-bytes
  - id: fallocate_ops
    type:
      - 'null'
      - int
    doc: stop after N fallocate bogo operations
    inputBinding:
      position: 101
      prefix: --fallocate-ops
  - id: fanotify
    type:
      - 'null'
      - int
    doc: start N workers exercising fanotify events
    inputBinding:
      position: 101
      prefix: --fanotify
  - id: fanotify_ops
    type:
      - 'null'
      - int
    doc: stop fanotify workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --fanotify-ops
  - id: fault
    type:
      - 'null'
      - int
    doc: start N workers producing page faults
    inputBinding:
      position: 101
      prefix: --fault
  - id: fault_ops
    type:
      - 'null'
      - int
    doc: stop after N page fault bogo operations
    inputBinding:
      position: 101
      prefix: --fault-ops
  - id: fcntl
    type:
      - 'null'
      - int
    doc: start N workers exercising fcntl commands
    inputBinding:
      position: 101
      prefix: --fcntl
  - id: fcntl_ops
    type:
      - 'null'
      - int
    doc: stop after N fcntl bogo operations
    inputBinding:
      position: 101
      prefix: --fcntl-ops
  - id: fiemap
    type:
      - 'null'
      - int
    doc: start N workers exercising the FIEMAP ioctl
    inputBinding:
      position: 101
      prefix: --fiemap
  - id: fiemap_bytes
    type:
      - 'null'
      - int
    doc: specify size of file to fiemap
    inputBinding:
      position: 101
      prefix: --fiemap-bytes
  - id: fiemap_ops
    type:
      - 'null'
      - int
    doc: stop after N FIEMAP ioctl bogo operations
    inputBinding:
      position: 101
      prefix: --fiemap-ops
  - id: fifo
    type:
      - 'null'
      - int
    doc: start N workers exercising fifo I/O
    inputBinding:
      position: 101
      prefix: --fifo
  - id: fifo_ops
    type:
      - 'null'
      - int
    doc: stop after N fifo bogo operations
    inputBinding:
      position: 101
      prefix: --fifo-ops
  - id: fifo_readers
    type:
      - 'null'
      - int
    doc: number of fifo reader stessors to start
    inputBinding:
      position: 101
      prefix: --fifo-readers
  - id: file_ioctl
    type:
      - 'null'
      - int
    doc: start N workers exercising file specific ioctls
    inputBinding:
      position: 101
      prefix: --file-ioctl
  - id: file_ioctl_ops
    type:
      - 'null'
      - int
    doc: stop after N file ioctl bogo operations
    inputBinding:
      position: 101
      prefix: --file-ioctl-ops
  - id: filename
    type:
      - 'null'
      - int
    doc: start N workers exercising filenames
    inputBinding:
      position: 101
      prefix: --filename
  - id: filename_ops
    type:
      - 'null'
      - int
    doc: stop after N filename bogo operations
    inputBinding:
      position: 101
      prefix: --filename-ops
  - id: filename_opts
    type:
      - 'null'
      - string
    doc: specify allowed filename options
    inputBinding:
      position: 101
      prefix: --filename-opts
  - id: flock
    type:
      - 'null'
      - int
    doc: start N workers locking a single file
    inputBinding:
      position: 101
      prefix: --flock
  - id: flock_ops
    type:
      - 'null'
      - int
    doc: stop after N flock bogo operations
    inputBinding:
      position: 101
      prefix: --flock-ops
  - id: fork
    type:
      - 'null'
      - int
    doc: start N workers spinning on fork() and exit()
    inputBinding:
      position: 101
      prefix: --fork
  - id: fork_max
    type:
      - 'null'
      - int
    doc: create P workers per iteration, default is 1
    inputBinding:
      position: 101
      prefix: --fork-max
  - id: fork_ops
    type:
      - 'null'
      - int
    doc: stop after N fork bogo operations
    inputBinding:
      position: 101
      prefix: --fork-ops
  - id: fp_error
    type:
      - 'null'
      - int
    doc: start N workers exercising floating point errors
    inputBinding:
      position: 101
      prefix: --fp-error
  - id: fp_error_ops
    type:
      - 'null'
      - int
    doc: stop after N fp-error bogo operations
    inputBinding:
      position: 101
      prefix: --fp-error-ops
  - id: fstat
    type:
      - 'null'
      - int
    doc: start N workers exercising fstat on files
    inputBinding:
      position: 101
      prefix: --fstat
  - id: fstat_dir
    type:
      - 'null'
      - Directory
    doc: fstat files in the specified directory
    inputBinding:
      position: 101
      prefix: --fstat-dir
  - id: fstat_ops
    type:
      - 'null'
      - int
    doc: stop after N fstat bogo operations
    inputBinding:
      position: 101
      prefix: --fstat-ops
  - id: full
    type:
      - 'null'
      - int
    doc: start N workers exercising /dev/full
    inputBinding:
      position: 101
      prefix: --full
  - id: full_ops
    type:
      - 'null'
      - int
    doc: stop after N /dev/full bogo I/O operations
    inputBinding:
      position: 101
      prefix: --full-ops
  - id: funccall
    type:
      - 'null'
      - int
    doc: start N workers exercising 1 to 9 arg functions
    inputBinding:
      position: 101
      prefix: --funccall
  - id: funccall_method
    type:
      - 'null'
      - string
    doc: select function call method M
    inputBinding:
      position: 101
      prefix: --funccall-method
  - id: funccall_ops
    type:
      - 'null'
      - int
    doc: stop after N function call bogo operations
    inputBinding:
      position: 101
      prefix: --funccall-ops
  - id: funcret
    type:
      - 'null'
      - int
    doc: start N workers exercising function return copying
    inputBinding:
      position: 101
      prefix: --funcret
  - id: funcret_method
    type:
      - 'null'
      - string
    doc: select method of exercising a function return type
    inputBinding:
      position: 101
      prefix: --funcret-method
  - id: funcret_ops
    type:
      - 'null'
      - int
    doc: stop after N function return bogo operations
    inputBinding:
      position: 101
      prefix: --funcret-ops
  - id: futex
    type:
      - 'null'
      - int
    doc: start N workers exercising a fast mutex
    inputBinding:
      position: 101
      prefix: --futex
  - id: futex_ops
    type:
      - 'null'
      - int
    doc: stop after N fast mutex bogo operations
    inputBinding:
      position: 101
      prefix: --futex-ops
  - id: get
    type:
      - 'null'
      - int
    doc: start N workers exercising the get*() system calls
    inputBinding:
      position: 101
      prefix: --get
  - id: get_ops
    type:
      - 'null'
      - int
    doc: stop after N get bogo operations
    inputBinding:
      position: 101
      prefix: --get-ops
  - id: getdent
    type:
      - 'null'
      - int
    doc: start N workers reading directories using getdents
    inputBinding:
      position: 101
      prefix: --getdent
  - id: getdent_ops
    type:
      - 'null'
      - int
    doc: stop after N getdents bogo operations
    inputBinding:
      position: 101
      prefix: --getdent-ops
  - id: getrandom
    type:
      - 'null'
      - int
    doc: start N workers fetching random data via getrandom()
    inputBinding:
      position: 101
      prefix: --getrandom
  - id: getrandom_ops
    type:
      - 'null'
      - int
    doc: stop after N getrandom bogo operations
    inputBinding:
      position: 101
      prefix: --getrandom-ops
  - id: handle
    type:
      - 'null'
      - int
    doc: start N workers exercising name_to_handle_at
    inputBinding:
      position: 101
      prefix: --handle
  - id: handle_ops
    type:
      - 'null'
      - int
    doc: stop after N handle bogo operations
    inputBinding:
      position: 101
      prefix: --handle-ops
  - id: hdd
    type:
      - 'null'
      - int
    doc: start N workers spinning on write()/unlink()
    inputBinding:
      position: 101
      prefix: --hdd
  - id: hdd_bytes
    type:
      - 'null'
      - int
    doc: write N bytes per hdd worker (default is 1GB)
    inputBinding:
      position: 101
      prefix: --hdd-bytes
  - id: hdd_ops
    type:
      - 'null'
      - int
    doc: stop after N hdd bogo operations
    inputBinding:
      position: 101
      prefix: --hdd-ops
  - id: hdd_opts
    type:
      - 'null'
      - string
    doc: specify list of various stressor options
    inputBinding:
      position: 101
      prefix: --hdd-opts
  - id: hdd_write_size
    type:
      - 'null'
      - int
    doc: set the default write size to N bytes
    inputBinding:
      position: 101
      prefix: --hdd-write-size
  - id: heapsort
    type:
      - 'null'
      - int
    doc: start N workers heap sorting 32 bit random integers
    inputBinding:
      position: 101
      prefix: --heapsort
  - id: heapsort_ops
    type:
      - 'null'
      - int
    doc: stop after N heap sort bogo operations
    inputBinding:
      position: 101
      prefix: --heapsort-ops
  - id: heapsort_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to sort
    inputBinding:
      position: 101
      prefix: --heapsort-size
  - id: hrtimers
    type:
      - 'null'
      - int
    doc: start N workers that exercise high resolution timers
    inputBinding:
      position: 101
      prefix: --hrtimers
  - id: hrtimers_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo high-res timer bogo operations
    inputBinding:
      position: 101
      prefix: --hrtimers-ops
  - id: hsearch
    type:
      - 'null'
      - int
    doc: start N workers that exercise a hash table search
    inputBinding:
      position: 101
      prefix: --hsearch
  - id: hsearch_ops
    type:
      - 'null'
      - int
    doc: stop after N hash search bogo operations
    inputBinding:
      position: 101
      prefix: --hsearch-ops
  - id: hsearch_size
    type:
      - 'null'
      - int
    doc: number of integers to insert into hash table
    inputBinding:
      position: 101
      prefix: --hsearch-size
  - id: icache
    type:
      - 'null'
      - int
    doc: start N CPU instruction cache thrashing workers
    inputBinding:
      position: 101
      prefix: --icache
  - id: icache_ops
    type:
      - 'null'
      - int
    doc: stop after N icache bogo operations
    inputBinding:
      position: 101
      prefix: --icache-ops
  - id: icmp_flood
    type:
      - 'null'
      - int
    doc: start N ICMP packet flood workers
    inputBinding:
      position: 101
      prefix: --icmp-flood
  - id: icmp_flood_ops
    type:
      - 'null'
      - int
    doc: stop after N ICMP bogo operations (ICMP packets)
    inputBinding:
      position: 101
      prefix: --icmp-flood-ops
  - id: idle_page
    type:
      - 'null'
      - int
    doc: start N idle page scanning workers
    inputBinding:
      position: 101
      prefix: --idle-page
  - id: idle_page_ops
    type:
      - 'null'
      - int
    doc: stop after N idle page scan bogo operations
    inputBinding:
      position: 101
      prefix: --idle-page-ops
  - id: ignite_cpu
    type:
      - 'null'
      - boolean
    doc: alter kernel controls to make CPU run hot
    inputBinding:
      position: 101
      prefix: --ignite-cpu
  - id: inode_flags
    type:
      - 'null'
      - int
    doc: start N workers exercising various inode flags
    inputBinding:
      position: 101
      prefix: --inode-flags
  - id: inode_flags_ops
    type:
      - 'null'
      - int
    doc: stop inode-flags workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --inode-flags-ops
  - id: inotify
    type:
      - 'null'
      - int
    doc: start N workers exercising inotify events
    inputBinding:
      position: 101
      prefix: --inotify
  - id: inotify_ops
    type:
      - 'null'
      - int
    doc: stop inotify workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --inotify-ops
  - id: io
    type:
      - 'null'
      - int
    doc: start N workers spinning on sync()
    inputBinding:
      position: 101
      prefix: --io
  - id: io_ops
    type:
      - 'null'
      - int
    doc: stop sync I/O after N io bogo operations
    inputBinding:
      position: 101
      prefix: --io-ops
  - id: io_uring
    type:
      - 'null'
      - int
    doc: start N workers that issue io-uring I/O requests
    inputBinding:
      position: 101
      prefix: --io-uring
  - id: io_uring_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo io-uring I/O requests
    inputBinding:
      position: 101
      prefix: --io-uring-ops
  - id: iomix
    type:
      - 'null'
      - int
    doc: start N workers that have a mix of I/O operations
    inputBinding:
      position: 101
      prefix: --iomix
  - id: iomix_bytes
    type:
      - 'null'
      - int
    doc: write N bytes per iomix worker (default is 1GB)
    inputBinding:
      position: 101
      prefix: --iomix-bytes
  - id: iomix_ops
    type:
      - 'null'
      - int
    doc: stop iomix workers after N iomix bogo operations
    inputBinding:
      position: 101
      prefix: --iomix-ops
  - id: ionice_class
    type:
      - 'null'
      - string
    doc: specify ionice class (idle, besteffort, realtime)
    inputBinding:
      position: 101
      prefix: --ionice-class
  - id: ionice_level
    type:
      - 'null'
      - int
    doc: specify ionice level (0 max, 7 min)
    inputBinding:
      position: 101
      prefix: --ionice-level
  - id: ioport
    type:
      - 'null'
      - int
    doc: start N workers exercising port I/O
    inputBinding:
      position: 101
      prefix: --ioport
  - id: ioport_ops
    type:
      - 'null'
      - int
    doc: stop ioport workers after N port bogo operations
    inputBinding:
      position: 101
      prefix: --ioport-ops
  - id: ioprio
    type:
      - 'null'
      - int
    doc: start N workers exercising set/get iopriority
    inputBinding:
      position: 101
      prefix: --ioprio
  - id: ioprio_ops
    type:
      - 'null'
      - int
    doc: stop after N io bogo iopriority operations
    inputBinding:
      position: 101
      prefix: --ioprio-ops
  - id: ipsec_mb
    type:
      - 'null'
      - int
    doc: start N workers exercising the IPSec MB encoding
    inputBinding:
      position: 101
      prefix: --ipsec-mb
  - id: ipsec_mb_feature
    type:
      - 'null'
      - string
    doc: specify CPU feature F
    inputBinding:
      position: 101
      prefix: --ipsec-mb-feature
  - id: ipsec_mb_ops
    type:
      - 'null'
      - int
    doc: stop after N ipsec bogo encoding operations
    inputBinding:
      position: 101
      prefix: --ipsec-mb-ops
  - id: itimer
    type:
      - 'null'
      - int
    doc: start N workers exercising interval timers
    inputBinding:
      position: 101
      prefix: --itimer
  - id: itimer_ops
    type:
      - 'null'
      - int
    doc: stop after N interval timer bogo operations
    inputBinding:
      position: 101
      prefix: --itimer-ops
  - id: itimer_rand
    type:
      - 'null'
      - boolean
    doc: enable random interval timer frequency
    inputBinding:
      position: 101
      prefix: --itimer-rand
  - id: jobfile
    type:
      - 'null'
      - File
    doc: run the named jobfile
    inputBinding:
      position: 101
      prefix: --job
  - id: judy
    type:
      - 'null'
      - int
    doc: start N workers that exercise a judy array search
    inputBinding:
      position: 101
      prefix: --judy
  - id: judy_ops
    type:
      - 'null'
      - int
    doc: stop after N judy array search bogo operations
    inputBinding:
      position: 101
      prefix: --judy-ops
  - id: judy_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to insert into judy array
    inputBinding:
      position: 101
      prefix: --judy-size
  - id: kcmp
    type:
      - 'null'
      - int
    doc: start N workers exercising kcmp
    inputBinding:
      position: 101
      prefix: --kcmp
  - id: kcmp_ops
    type:
      - 'null'
      - int
    doc: stop after N kcmp bogo operations
    inputBinding:
      position: 101
      prefix: --kcmp-ops
  - id: keep_name
    type:
      - 'null'
      - boolean
    doc: keep stress worker names to be 'stress-ng'
    inputBinding:
      position: 101
      prefix: --keep-name
  - id: key
    type:
      - 'null'
      - int
    doc: start N workers exercising key operations
    inputBinding:
      position: 101
      prefix: --key
  - id: key_ops
    type:
      - 'null'
      - int
    doc: stop after N key bogo operations
    inputBinding:
      position: 101
      prefix: --key-ops
  - id: kill
    type:
      - 'null'
      - int
    doc: start N workers killing with SIGUSR1
    inputBinding:
      position: 101
      prefix: --kill
  - id: kill_ops
    type:
      - 'null'
      - int
    doc: stop after N kill bogo operations
    inputBinding:
      position: 101
      prefix: --kill-ops
  - id: klog
    type:
      - 'null'
      - int
    doc: start N workers exercising kernel syslog interface
    inputBinding:
      position: 101
      prefix: --klog
  - id: klog_ops
    type:
      - 'null'
      - int
    doc: stop after N klog bogo operations
    inputBinding:
      position: 101
      prefix: --klog-ops
  - id: lease
    type:
      - 'null'
      - int
    doc: start N workers holding and breaking a lease
    inputBinding:
      position: 101
      prefix: --lease
  - id: lease_breakers
    type:
      - 'null'
      - int
    doc: number of lease breaking workers to start
    inputBinding:
      position: 101
      prefix: --lease-breakers
  - id: lease_ops
    type:
      - 'null'
      - int
    doc: stop after N lease bogo operations
    inputBinding:
      position: 101
      prefix: --lease-ops
  - id: link
    type:
      - 'null'
      - int
    doc: start N workers creating hard links
    inputBinding:
      position: 101
      prefix: --link
  - id: link_ops
    type:
      - 'null'
      - int
    doc: stop after N link bogo operations
    inputBinding:
      position: 101
      prefix: --link-ops
  - id: locka
    type:
      - 'null'
      - int
    doc: start N workers locking a file via advisory locks
    inputBinding:
      position: 101
      prefix: --locka
  - id: locka_ops
    type:
      - 'null'
      - int
    doc: stop after N locka bogo operations
    inputBinding:
      position: 101
      prefix: --locka-ops
  - id: lockbus
    type:
      - 'null'
      - int
    doc: start N workers locking a memory increment
    inputBinding:
      position: 101
      prefix: --lockbus
  - id: lockbus_ops
    type:
      - 'null'
      - int
    doc: stop after N lockbus bogo operations
    inputBinding:
      position: 101
      prefix: --lockbus-ops
  - id: lockf
    type:
      - 'null'
      - int
    doc: start N workers locking a single file via lockf
    inputBinding:
      position: 101
      prefix: --lockf
  - id: lockf_nonblock
    type:
      - 'null'
      - boolean
    doc: don't block if lock cannot be obtained, re-try
    inputBinding:
      position: 101
      prefix: --lockf-nonblock
  - id: lockf_ops
    type:
      - 'null'
      - int
    doc: stop after N lockf bogo operations
    inputBinding:
      position: 101
      prefix: --lockf-ops
  - id: lockofd
    type:
      - 'null'
      - int
    doc: start N workers using open file description locking
    inputBinding:
      position: 101
      prefix: --lockofd
  - id: lockofd_ops
    type:
      - 'null'
      - int
    doc: stop after N lockofd bogo operations
    inputBinding:
      position: 101
      prefix: --lockofd-ops
  - id: log_brief
    type:
      - 'null'
      - boolean
    doc: less verbose log messages
    inputBinding:
      position: 101
      prefix: --log-brief
  - id: log_file
    type:
      - 'null'
      - File
    doc: log messages to a log file
    inputBinding:
      position: 101
      prefix: --log-file
  - id: longjmp
    type:
      - 'null'
      - int
    doc: start N workers exercising setjmp/longjmp
    inputBinding:
      position: 101
      prefix: --longjmp
  - id: longjmp_ops
    type:
      - 'null'
      - int
    doc: stop after N longjmp bogo operations
    inputBinding:
      position: 101
      prefix: --longjmp-ops
  - id: loop
    type:
      - 'null'
      - int
    doc: start N workers exercising loopback devices
    inputBinding:
      position: 101
      prefix: --loop
  - id: loop_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo loopback operations
    inputBinding:
      position: 101
      prefix: --loop-ops
  - id: lsearch
    type:
      - 'null'
      - int
    doc: start N workers that exercise a linear search
    inputBinding:
      position: 101
      prefix: --lsearch
  - id: lsearch_ops
    type:
      - 'null'
      - int
    doc: stop after N linear search bogo operations
    inputBinding:
      position: 101
      prefix: --lsearch-ops
  - id: lsearch_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to lsearch
    inputBinding:
      position: 101
      prefix: --lsearch-size
  - id: madvise
    type:
      - 'null'
      - int
    doc: start N workers exercising madvise on memory
    inputBinding:
      position: 101
      prefix: --madvise
  - id: madvise_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo madvise operations
    inputBinding:
      position: 101
      prefix: --madvise-ops
  - id: malloc
    type:
      - 'null'
      - int
    doc: start N workers exercising malloc/realloc/free
    inputBinding:
      position: 101
      prefix: --malloc
  - id: malloc_bytes
    type:
      - 'null'
      - int
    doc: allocate up to N bytes per allocation
    inputBinding:
      position: 101
      prefix: --malloc-bytes
  - id: malloc_max
    type:
      - 'null'
      - int
    doc: keep up to N allocations at a time
    inputBinding:
      position: 101
      prefix: --malloc-max
  - id: malloc_ops
    type:
      - 'null'
      - int
    doc: stop after N malloc bogo operations
    inputBinding:
      position: 101
      prefix: --malloc-ops
  - id: malloc_pthreads
    type:
      - 'null'
      - int
    doc: number of pthreads to run concurrently
    inputBinding:
      position: 101
      prefix: --malloc-pthreads
  - id: malloc_thresh
    type:
      - 'null'
      - int
    doc: threshold where malloc uses mmap instead of sbrk
    inputBinding:
      position: 101
      prefix: --malloc-thresh
  - id: matrix
    type:
      - 'null'
      - int
    doc: start N workers exercising matrix operations
    inputBinding:
      position: 101
      prefix: --matrix
  - id: matrix_3d
    type:
      - 'null'
      - int
    doc: start N workers exercising 3D matrix operations
    inputBinding:
      position: 101
      prefix: --matrix-3d
  - id: matrix_3d_method
    type:
      - 'null'
      - string
    doc: specify 3D matrix stress method M, default is all
    inputBinding:
      position: 101
      prefix: --matrix-3d-method
  - id: matrix_3d_ops
    type:
      - 'null'
      - int
    doc: stop after N 3D maxtrix bogo operations
    inputBinding:
      position: 101
      prefix: --matrix-3d-ops
  - id: matrix_3d_size
    type:
      - 'null'
      - int
    doc: specify the size of the N x N x N matrix
    inputBinding:
      position: 101
      prefix: --matrix-3d-size
  - id: matrix_3d_zyx
    type:
      - 'null'
      - boolean
    doc: matrix operation is z by y by x instead of x by y by z
    inputBinding:
      position: 101
      prefix: --matrix-3d-zyx
  - id: matrix_method
    type:
      - 'null'
      - string
    doc: specify matrix stress method M, default is all
    inputBinding:
      position: 101
      prefix: --matrix-method
  - id: matrix_ops
    type:
      - 'null'
      - int
    doc: stop after N maxtrix bogo operations
    inputBinding:
      position: 101
      prefix: --matrix-ops
  - id: matrix_size
    type:
      - 'null'
      - int
    doc: specify the size of the N x N matrix
    inputBinding:
      position: 101
      prefix: --matrix-size
  - id: matrix_yx
    type:
      - 'null'
      - boolean
    doc: matrix operation is y by x instead of x by y
    inputBinding:
      position: 101
      prefix: --matrix-yx
  - id: max_fd
    type:
      - 'null'
      - boolean
    doc: set maximum file descriptor limit
    inputBinding:
      position: 101
      prefix: --max-fd
  - id: maximize
    type:
      - 'null'
      - boolean
    doc: enable maximum stress options
    inputBinding:
      position: 101
      prefix: --maximize
  - id: mcontend
    type:
      - 'null'
      - int
    doc: start N workers that produce memory contention
    inputBinding:
      position: 101
      prefix: --mcontend
  - id: mcontend_ops
    type:
      - 'null'
      - int
    doc: stop memory contention workers after N bogo-ops
    inputBinding:
      position: 101
      prefix: --mcontend-ops
  - id: membarrier
    type:
      - 'null'
      - int
    doc: start N workers performing membarrier system calls
    inputBinding:
      position: 101
      prefix: --membarrier
  - id: membarrier_ops
    type:
      - 'null'
      - int
    doc: stop after N membarrier bogo operations
    inputBinding:
      position: 101
      prefix: --membarrier-ops
  - id: memcpy
    type:
      - 'null'
      - int
    doc: start N workers performing memory copies
    inputBinding:
      position: 101
      prefix: --memcpy
  - id: memcpy_method
    type:
      - 'null'
      - string
    doc: set memcpy method (M = all, libc, builtin, naive)
    inputBinding:
      position: 101
      prefix: --memcpy-method
  - id: memcpy_ops
    type:
      - 'null'
      - int
    doc: stop after N memcpy bogo operations
    inputBinding:
      position: 101
      prefix: --memcpy-ops
  - id: memfd
    type:
      - 'null'
      - int
    doc: start N workers allocating memory with memfd_create
    inputBinding:
      position: 101
      prefix: --memfd
  - id: memfd_bytes
    type:
      - 'null'
      - int
    doc: allocate N bytes for each stress iteration
    inputBinding:
      position: 101
      prefix: --memfd-bytes
  - id: memfd_fds
    type:
      - 'null'
      - int
    doc: number of memory fds to open per stressors
    inputBinding:
      position: 101
      prefix: --memfd-fds
  - id: memfd_ops
    type:
      - 'null'
      - int
    doc: stop after N memfd bogo operations
    inputBinding:
      position: 101
      prefix: --memfd-ops
  - id: memhotplug
    type:
      - 'null'
      - int
    doc: start N workers that exercise memory hotplug
    inputBinding:
      position: 101
      prefix: --memhotplug
  - id: memhotplug_ops
    type:
      - 'null'
      - int
    doc: stop after N memory hotplug operations
    inputBinding:
      position: 101
      prefix: --memhotplug-ops
  - id: memrate
    type:
      - 'null'
      - int
    doc: start N workers exercised memory read/writes
    inputBinding:
      position: 101
      prefix: --memrate
  - id: memrate_bytes
    type:
      - 'null'
      - int
    doc: size of memory buffer being exercised
    inputBinding:
      position: 101
      prefix: --memrate-bytes
  - id: memrate_ops
    type:
      - 'null'
      - int
    doc: stop after N memrate bogo operations
    inputBinding:
      position: 101
      prefix: --memrate-ops
  - id: memrate_rd_mbs
    type:
      - 'null'
      - int
    doc: read rate from buffer in megabytes per second
    inputBinding:
      position: 101
      prefix: --memrate-rd-mbs
  - id: memrate_wr_mbs
    type:
      - 'null'
      - int
    doc: write rate to buffer in megabytes per second
    inputBinding:
      position: 101
      prefix: --memrate-wr-mbs
  - id: memthrash
    type:
      - 'null'
      - int
    doc: start N workers thrashing a 16MB memory buffer
    inputBinding:
      position: 101
      prefix: --memthrash
  - id: memthrash_method
    type:
      - 'null'
      - string
    doc: specify memthrash method M, default is all
    inputBinding:
      position: 101
      prefix: --memthrash-method
  - id: memthrash_ops
    type:
      - 'null'
      - int
    doc: stop after N memthrash bogo operations
    inputBinding:
      position: 101
      prefix: --memthrash-ops
  - id: mergesort
    type:
      - 'null'
      - int
    doc: start N workers merge sorting 32 bit random integers
    inputBinding:
      position: 101
      prefix: --mergesort
  - id: mergesort_ops
    type:
      - 'null'
      - int
    doc: stop after N merge sort bogo operations
    inputBinding:
      position: 101
      prefix: --mergesort-ops
  - id: mergesort_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to sort
    inputBinding:
      position: 101
      prefix: --mergesort-size
  - id: metrics
    type:
      - 'null'
      - boolean
    doc: print pseudo metrics of activity
    inputBinding:
      position: 101
      prefix: --metrics
  - id: metrics_brief
    type:
      - 'null'
      - boolean
    doc: enable metrics and only show non-zero results
    inputBinding:
      position: 101
      prefix: --metrics-brief
  - id: mincore
    type:
      - 'null'
      - int
    doc: start N workers exercising mincore
    inputBinding:
      position: 101
      prefix: --mincore
  - id: mincore_ops
    type:
      - 'null'
      - int
    doc: stop after N mincore bogo operations
    inputBinding:
      position: 101
      prefix: --mincore-ops
  - id: mincore_random
    type:
      - 'null'
      - boolean
    doc: randomly select pages rather than linear scan
    inputBinding:
      position: 101
      prefix: --mincore-random
  - id: minimize
    type:
      - 'null'
      - boolean
    doc: enable minimal stress options
    inputBinding:
      position: 101
      prefix: --minimize
  - id: mknod
    type:
      - 'null'
      - int
    doc: start N workers that exercise mknod
    inputBinding:
      position: 101
      prefix: --mknod
  - id: mknod_ops
    type:
      - 'null'
      - int
    doc: stop after N mknod bogo operations
    inputBinding:
      position: 101
      prefix: --mknod-ops
  - id: mlock
    type:
      - 'null'
      - int
    doc: start N workers exercising mlock/munlock
    inputBinding:
      position: 101
      prefix: --mlock
  - id: mlock_ops
    type:
      - 'null'
      - int
    doc: stop after N mlock bogo operations
    inputBinding:
      position: 101
      prefix: --mlock-ops
  - id: mlockmany
    type:
      - 'null'
      - int
    doc: start N workers exercising many mlock/munlock processes
    inputBinding:
      position: 101
      prefix: --mlockmany
  - id: mlockmany_ops
    type:
      - 'null'
      - int
    doc: stop after N mlockmany bogo operations
    inputBinding:
      position: 101
      prefix: --mlockmany-ops
  - id: mmap
    type:
      - 'null'
      - int
    doc: start N workers stressing mmap and munmap
    inputBinding:
      position: 101
      prefix: --mmap
  - id: mmap_async
    type:
      - 'null'
      - boolean
    doc: using asynchronous msyncs for file based mmap
    inputBinding:
      position: 101
      prefix: --mmap-async
  - id: mmap_bytes
    type:
      - 'null'
      - int
    doc: mmap and munmap N bytes for each stress iteration
    inputBinding:
      position: 101
      prefix: --mmap-bytes
  - id: mmap_file
    type:
      - 'null'
      - boolean
    doc: mmap onto a file using synchronous msyncs
    inputBinding:
      position: 101
      prefix: --mmap-file
  - id: mmap_mprotect
    type:
      - 'null'
      - boolean
    doc: enable mmap mprotect stressing
    inputBinding:
      position: 101
      prefix: --mmap-mprotect
  - id: mmap_odirect
    type:
      - 'null'
      - boolean
    doc: enable O_DIRECT on file
    inputBinding:
      position: 101
      prefix: --mmap-odirect
  - id: mmap_ops
    type:
      - 'null'
      - int
    doc: stop after N mmap bogo operations
    inputBinding:
      position: 101
      prefix: --mmap-ops
  - id: mmap_osync
    type:
      - 'null'
      - boolean
    doc: enable O_SYNC on file
    inputBinding:
      position: 101
      prefix: --mmap-osync
  - id: mmapaddr
    type:
      - 'null'
      - int
    doc: start N workers stressing mmap with random addresses
    inputBinding:
      position: 101
      prefix: --mmapaddr
  - id: mmapaddr_ops
    type:
      - 'null'
      - int
    doc: stop after N mmapaddr bogo operations
    inputBinding:
      position: 101
      prefix: --mmapaddr-ops
  - id: mmapfixed
    type:
      - 'null'
      - int
    doc: start N workers stressing mmap with fixed mappings
    inputBinding:
      position: 101
      prefix: --mmapfixed
  - id: mmapfixed_ops
    type:
      - 'null'
      - int
    doc: stop after N mmapfixed bogo operations
    inputBinding:
      position: 101
      prefix: --mmapfixed-ops
  - id: mmapfork
    type:
      - 'null'
      - int
    doc: start N workers stressing many forked mmaps/munmaps
    inputBinding:
      position: 101
      prefix: --mmapfork
  - id: mmapfork_ops
    type:
      - 'null'
      - int
    doc: stop after N mmapfork bogo operations
    inputBinding:
      position: 101
      prefix: --mmapfork-ops
  - id: mmapmany
    type:
      - 'null'
      - int
    doc: start N workers stressing many mmaps and munmaps
    inputBinding:
      position: 101
      prefix: --mmapmany
  - id: mmapmany_ops
    type:
      - 'null'
      - int
    doc: stop after N mmapmany bogo operations
    inputBinding:
      position: 101
      prefix: --mmapmany-ops
  - id: mq
    type:
      - 'null'
      - int
    doc: start N workers passing messages using POSIX messages
    inputBinding:
      position: 101
      prefix: --mq
  - id: mq_ops
    type:
      - 'null'
      - int
    doc: stop mq workers after N bogo messages
    inputBinding:
      position: 101
      prefix: --mq-ops
  - id: mq_size
    type:
      - 'null'
      - int
    doc: specify the size of the POSIX message queue
    inputBinding:
      position: 101
      prefix: --mq-size
  - id: mremap
    type:
      - 'null'
      - int
    doc: start N workers stressing mremap
    inputBinding:
      position: 101
      prefix: --mremap
  - id: mremap_bytes
    type:
      - 'null'
      - int
    doc: mremap N bytes maximum for each stress iteration
    inputBinding:
      position: 101
      prefix: --mremap-bytes
  - id: mremap_lock
    type:
      - 'null'
      - boolean
    doc: mlock remap pages, force pages to be unswappable
    inputBinding:
      position: 101
      prefix: --mremap-lock
  - id: mremap_ops
    type:
      - 'null'
      - int
    doc: stop after N mremap bogo operations
    inputBinding:
      position: 101
      prefix: --mremap-ops
  - id: msg
    type:
      - 'null'
      - int
    doc: start N workers stressing System V messages
    inputBinding:
      position: 101
      prefix: --msg
  - id: msg_ops
    type:
      - 'null'
      - int
    doc: stop msg workers after N bogo messages
    inputBinding:
      position: 101
      prefix: --msg-ops
  - id: msg_types
    type:
      - 'null'
      - int
    doc: enable N different message types
    inputBinding:
      position: 101
      prefix: --msg-types
  - id: msync
    type:
      - 'null'
      - int
    doc: start N workers syncing mmap'd data with msync
    inputBinding:
      position: 101
      prefix: --msync
  - id: msync_bytes
    type:
      - 'null'
      - int
    doc: size of file and memory mapped region to msync
    inputBinding:
      position: 101
      prefix: --msync-bytes
  - id: msync_ops
    type:
      - 'null'
      - int
    doc: stop msync workers after N bogo msyncs
    inputBinding:
      position: 101
      prefix: --msync-ops
  - id: nanosleep
    type:
      - 'null'
      - int
    doc: start N workers performing short sleeps
    inputBinding:
      position: 101
      prefix: --nanosleep
  - id: nanosleep_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo sleep operations
    inputBinding:
      position: 101
      prefix: --nanosleep-ops
  - id: netdev
    type:
      - 'null'
      - int
    doc: start N workers exercising netdevice ioctls
    inputBinding:
      position: 101
      prefix: --netdev
  - id: netdev_ops
    type:
      - 'null'
      - int
    doc: stop netdev workers after N bogo operations
    inputBinding:
      position: 101
      prefix: --netdev-ops
  - id: netlink_proc
    type:
      - 'null'
      - int
    doc: start N workers exercising netlink process events
    inputBinding:
      position: 101
      prefix: --netlink-proc
  - id: netlink_proc_ops
    type:
      - 'null'
      - int
    doc: stop netlink-proc workers after N bogo events
    inputBinding:
      position: 101
      prefix: --netlink-proc-ops
  - id: netlink_task
    type:
      - 'null'
      - int
    doc: start N workers exercising netlink tasks events
    inputBinding:
      position: 101
      prefix: --netlink-task
  - id: netlink_task_ops
    type:
      - 'null'
      - int
    doc: stop netlink-task workers after N bogo events
    inputBinding:
      position: 101
      prefix: --netlink-task-ops
  - id: nice
    type:
      - 'null'
      - int
    doc: start N workers that randomly re-adjust nice levels
    inputBinding:
      position: 101
      prefix: --nice
  - id: nice_ops
    type:
      - 'null'
      - int
    doc: stop after N nice bogo operations
    inputBinding:
      position: 101
      prefix: --nice-ops
  - id: no_madvise
    type:
      - 'null'
      - boolean
    doc: don't use random madvise options for each mmap
    inputBinding:
      position: 101
      prefix: --no-madvise
  - id: no_rand_seed
    type:
      - 'null'
      - boolean
    doc: seed random numbers with the same constant
    inputBinding:
      position: 101
      prefix: --no-rand-seed
  - id: nop
    type:
      - 'null'
      - int
    doc: start N workers that burn cycles with no-ops
    inputBinding:
      position: 101
      prefix: --nop
  - id: nop_ops
    type:
      - 'null'
      - int
    doc: stop after N nop bogo no-op operations
    inputBinding:
      position: 101
      prefix: --nop-ops
  - id: 'null'
    type:
      - 'null'
      - int
    doc: start N workers writing to /dev/null
    inputBinding:
      position: 101
      prefix: --null
  - id: null_ops
    type:
      - 'null'
      - int
    doc: stop after N /dev/null bogo write operations
    inputBinding:
      position: 101
      prefix: --null-ops
  - id: numa
    type:
      - 'null'
      - int
    doc: start N workers stressing NUMA interfaces
    inputBinding:
      position: 101
      prefix: --numa
  - id: numa_ops
    type:
      - 'null'
      - int
    doc: stop after N NUMA bogo operations
    inputBinding:
      position: 101
      prefix: --numa-ops
  - id: oom_pipe
    type:
      - 'null'
      - int
    doc: start N workers exercising large pipes
    inputBinding:
      position: 101
      prefix: --oom-pipe
  - id: oom_pipe_ops
    type:
      - 'null'
      - int
    doc: stop after N oom-pipe bogo operations
    inputBinding:
      position: 101
      prefix: --oom-pipe-ops
  - id: opcode
    type:
      - 'null'
      - int
    doc: start N workers exercising random opcodes
    inputBinding:
      position: 101
      prefix: --opcode
  - id: opcode_method
    type:
      - 'null'
      - string
    doc: set opcode stress method (M = random, inc, mixed, text)
    inputBinding:
      position: 101
      prefix: --opcode-method
  - id: opcode_ops
    type:
      - 'null'
      - int
    doc: stop after N opcode bogo operations
    inputBinding:
      position: 101
      prefix: --opcode-ops
  - id: open
    type:
      - 'null'
      - int
    doc: start N workers exercising open/close
    inputBinding:
      position: 101
      prefix: --open
  - id: open_fd
    type:
      - 'null'
      - boolean
    doc: open files in /proc/$pid/fd
    inputBinding:
      position: 101
      prefix: --open-fd
  - id: open_ops
    type:
      - 'null'
      - int
    doc: stop after N open/close bogo operations
    inputBinding:
      position: 101
      prefix: --open-ops
  - id: page_in
    type:
      - 'null'
      - boolean
    doc: touch allocated pages that are not in core
    inputBinding:
      position: 101
      prefix: --page-in
  - id: parallel
    type:
      - 'null'
      - int
    doc: synonym for 'all N'
    inputBinding:
      position: 101
      prefix: --parallel
  - id: pathological
    type:
      - 'null'
      - boolean
    doc: enable stressors that are known to hang a machine
    inputBinding:
      position: 101
      prefix: --pathological
  - id: perf
    type:
      - 'null'
      - boolean
    doc: display perf statistics
    inputBinding:
      position: 101
      prefix: --perf
  - id: personality
    type:
      - 'null'
      - int
    doc: start N workers that change their personality
    inputBinding:
      position: 101
      prefix: --personality
  - id: personality_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo personality calls
    inputBinding:
      position: 101
      prefix: --personality-ops
  - id: physpage
    type:
      - 'null'
      - int
    doc: start N workers performing physical page lookup
    inputBinding:
      position: 101
      prefix: --physpage
  - id: physpage_ops
    type:
      - 'null'
      - int
    doc: stop after N physical page bogo operations
    inputBinding:
      position: 101
      prefix: --physpage-ops
  - id: pidfd
    type:
      - 'null'
      - int
    doc: start N workers exercising pidfd system call
    inputBinding:
      position: 101
      prefix: --pidfd
  - id: pidfd_ops
    type:
      - 'null'
      - int
    doc: stop after N pidfd bogo operations
    inputBinding:
      position: 101
      prefix: --pidfd-ops
  - id: ping_sock
    type:
      - 'null'
      - int
    doc: start N workers that exercises a ping socket
    inputBinding:
      position: 101
      prefix: --ping-sock
  - id: ping_sock_ops
    type:
      - 'null'
      - int
    doc: stop after N ping sendto messages
    inputBinding:
      position: 101
      prefix: --ping-sock-ops
  - id: pipe
    type:
      - 'null'
      - int
    doc: start N workers exercising pipe I/O
    inputBinding:
      position: 101
      prefix: --pipe
  - id: pipe_data_size
    type:
      - 'null'
      - int
    doc: set pipe size of each pipe write to N bytes
    inputBinding:
      position: 101
      prefix: --pipe-data-size
  - id: pipe_ops
    type:
      - 'null'
      - int
    doc: stop after N pipe I/O bogo operations
    inputBinding:
      position: 101
      prefix: --pipe-ops
  - id: pipeherd
    type:
      - 'null'
      - int
    doc: start N multi-process workers exercising pipes I/O
    inputBinding:
      position: 101
      prefix: --pipeherd
  - id: pipeherd_ops
    type:
      - 'null'
      - int
    doc: stop after N pipeherd I/O bogo operations
    inputBinding:
      position: 101
      prefix: --pipeherd-ops
  - id: pipeherd_yield
    type:
      - 'null'
      - boolean
    doc: force processes to yield after each write
    inputBinding:
      position: 101
      prefix: --pipeherd-yield
  - id: pkey
    type:
      - 'null'
      - int
    doc: start N workers exercising pkey_mprotect
    inputBinding:
      position: 101
      prefix: --pkey
  - id: pkey_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo pkey_mprotect bogo operations
    inputBinding:
      position: 101
      prefix: --pkey-ops
  - id: poll
    type:
      - 'null'
      - int
    doc: start N workers exercising zero timeout polling
    inputBinding:
      position: 101
      prefix: --poll
  - id: poll_fds
    type:
      - 'null'
      - int
    doc: use N file descriptors
    inputBinding:
      position: 101
      prefix: --poll-fds
  - id: poll_ops
    type:
      - 'null'
      - int
    doc: stop after N poll bogo operations
    inputBinding:
      position: 101
      prefix: --poll-ops
  - id: procfs
    type:
      - 'null'
      - int
    doc: start N workers reading portions of /proc
    inputBinding:
      position: 101
      prefix: --procfs
  - id: procfs_ops
    type:
      - 'null'
      - int
    doc: stop procfs workers after N bogo read operations
    inputBinding:
      position: 101
      prefix: --procfs-ops
  - id: pthread
    type:
      - 'null'
      - int
    doc: start N workers that create multiple threads
    inputBinding:
      position: 101
      prefix: --pthread
  - id: pthread_max
    type:
      - 'null'
      - int
    doc: create P threads at a time by each worker
    inputBinding:
      position: 101
      prefix: --pthread-max
  - id: pthread_ops
    type:
      - 'null'
      - int
    doc: stop pthread workers after N bogo threads created
    inputBinding:
      position: 101
      prefix: --pthread-ops
  - id: ptrace
    type:
      - 'null'
      - int
    doc: start N workers that trace a child using ptrace
    inputBinding:
      position: 101
      prefix: --ptrace
  - id: ptrace_ops
    type:
      - 'null'
      - int
    doc: stop ptrace workers after N system calls are traced
    inputBinding:
      position: 101
      prefix: --ptrace-ops
  - id: pty
    type:
      - 'null'
      - int
    doc: start N workers that exercise pseudoterminals
    inputBinding:
      position: 101
      prefix: --pty
  - id: pty_max
    type:
      - 'null'
      - int
    doc: attempt to open a maximum of N ptys
    inputBinding:
      position: 101
      prefix: --pty-max
  - id: pty_ops
    type:
      - 'null'
      - int
    doc: stop pty workers after N pty bogo operations
    inputBinding:
      position: 101
      prefix: --pty-ops
  - id: qsort
    type:
      - 'null'
      - int
    doc: start N workers qsorting 32 bit random integers
    inputBinding:
      position: 101
      prefix: --qsort
  - id: qsort_ops
    type:
      - 'null'
      - int
    doc: stop after N qsort bogo operations
    inputBinding:
      position: 101
      prefix: --qsort-ops
  - id: qsort_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to sort
    inputBinding:
      position: 101
      prefix: --qsort-size
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: quota
    type:
      - 'null'
      - int
    doc: start N workers exercising quotactl commands
    inputBinding:
      position: 101
      prefix: --quota
  - id: quota_ops
    type:
      - 'null'
      - int
    doc: stop after N quotactl bogo operations
    inputBinding:
      position: 101
      prefix: --quota-ops
  - id: radixsort
    type:
      - 'null'
      - int
    doc: start N workers radix sorting random strings
    inputBinding:
      position: 101
      prefix: --radixsort
  - id: radixsort_ops
    type:
      - 'null'
      - int
    doc: stop after N radixsort bogo operations
    inputBinding:
      position: 101
      prefix: --radixsort-ops
  - id: radixsort_size
    type:
      - 'null'
      - int
    doc: number of strings to sort
    inputBinding:
      position: 101
      prefix: --radixsort-size
  - id: ramfs
    type:
      - 'null'
      - int
    doc: start N workers exercising ramfs mounts
    inputBinding:
      position: 101
      prefix: --ramfs
  - id: ramfs_bytes
    type:
      - 'null'
      - int
    doc: set the ramfs size in bytes, e.g. 2M is 2MB
    inputBinding:
      position: 101
      prefix: --ramfs-bytes
  - id: ramfs_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo ramfs mount operations
    inputBinding:
      position: 101
      prefix: --ramfs-ops
  - id: random
    type:
      - 'null'
      - int
    doc: start N random workers
    inputBinding:
      position: 101
      prefix: --random
  - id: rawdev
    type:
      - 'null'
      - int
    doc: start N workers that read a raw device
    inputBinding:
      position: 101
      prefix: --rawdev
  - id: rawdev_method
    type:
      - 'null'
      - string
    doc: specify the rawdev reead method to use
    inputBinding:
      position: 101
      prefix: --rawdev-method
  - id: rawdev_ops
    type:
      - 'null'
      - int
    doc: stop after N rawdev read operations
    inputBinding:
      position: 101
      prefix: --rawdev-ops
  - id: rawpkt
    type:
      - 'null'
      - int
    doc: start N workers exercising raw packets
    inputBinding:
      position: 101
      prefix: --rawpkt
  - id: rawpkt_ops
    type:
      - 'null'
      - int
    doc: stop after N raw packet bogo operations
    inputBinding:
      position: 101
      prefix: --rawpkt-ops
  - id: rawpkt_port
    type:
      - 'null'
      - int
    doc: use raw packet ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --rawpkt-port
  - id: rawsock
    type:
      - 'null'
      - int
    doc: start N workers performing raw socket send/receives
    inputBinding:
      position: 101
      prefix: --rawsock
  - id: rawsock_ops
    type:
      - 'null'
      - int
    doc: stop after N raw socket bogo operations
    inputBinding:
      position: 101
      prefix: --rawsock-ops
  - id: rawudp
    type:
      - 'null'
      - int
    doc: start N workers exercising raw UDP socket I/O
    inputBinding:
      position: 101
      prefix: --rawudp
  - id: rawudp_ops
    type:
      - 'null'
      - int
    doc: stop after N raw socket UDP bogo operations
    inputBinding:
      position: 101
      prefix: --rawudp-ops
  - id: rawudp_port
    type:
      - 'null'
      - int
    doc: use raw socket ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --rawudp-port
  - id: rdrand
    type:
      - 'null'
      - int
    doc: start N workers exercising rdrand (x86 only)
    inputBinding:
      position: 101
      prefix: --rdrand
  - id: rdrand_ops
    type:
      - 'null'
      - int
    doc: stop after N rdrand bogo operations
    inputBinding:
      position: 101
      prefix: --rdrand-ops
  - id: readahead
    type:
      - 'null'
      - int
    doc: start N workers exercising file readahead
    inputBinding:
      position: 101
      prefix: --readahead
  - id: readahead_bytes
    type:
      - 'null'
      - int
    doc: size of file to readahead on (default is 1GB)
    inputBinding:
      position: 101
      prefix: --readahead-bytes
  - id: readahead_ops
    type:
      - 'null'
      - int
    doc: stop after N readahead bogo operations
    inputBinding:
      position: 101
      prefix: --readahead-ops
  - id: reboot
    type:
      - 'null'
      - int
    doc: start N workers that exercise bad reboot calls
    inputBinding:
      position: 101
      prefix: --reboot
  - id: reboot_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo reboot operations
    inputBinding:
      position: 101
      prefix: --reboot-ops
  - id: remap
    type:
      - 'null'
      - int
    doc: start N workers exercising page remappings
    inputBinding:
      position: 101
      prefix: --remap
  - id: remap_ops
    type:
      - 'null'
      - int
    doc: stop after N remapping bogo operations
    inputBinding:
      position: 101
      prefix: --remap-ops
  - id: rename
    type:
      - 'null'
      - int
    doc: start N workers exercising file renames
    inputBinding:
      position: 101
      prefix: --rename
  - id: rename_ops
    type:
      - 'null'
      - int
    doc: stop after N rename bogo operations
    inputBinding:
      position: 101
      prefix: --rename-ops
  - id: resources
    type:
      - 'null'
      - int
    doc: start N workers consuming system resources
    inputBinding:
      position: 101
      prefix: --resources
  - id: resources_ops
    type:
      - 'null'
      - int
    doc: stop after N resource bogo operations
    inputBinding:
      position: 101
      prefix: --resources-ops
  - id: revio
    type:
      - 'null'
      - int
    doc: start N workers performing reverse I/O
    inputBinding:
      position: 101
      prefix: --revio
  - id: revio_ops
    type:
      - 'null'
      - int
    doc: stop after N revio bogo operations
    inputBinding:
      position: 101
      prefix: --revio-ops
  - id: rmap
    type:
      - 'null'
      - int
    doc: start N workers that stress reverse mappings
    inputBinding:
      position: 101
      prefix: --rmap
  - id: rmap_ops
    type:
      - 'null'
      - int
    doc: stop after N rmap bogo operations
    inputBinding:
      position: 101
      prefix: --rmap-ops
  - id: rseq
    type:
      - 'null'
      - int
    doc: start N workers that exercise restartable sequences
    inputBinding:
      position: 101
      prefix: --rseq
  - id: rseq_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo restartable sequence operations
    inputBinding:
      position: 101
      prefix: --rseq-ops
  - id: rtc
    type:
      - 'null'
      - int
    doc: start N workers that exercise the RTC interfaces
    inputBinding:
      position: 101
      prefix: --rtc
  - id: rtc_ops
    type:
      - 'null'
      - int
    doc: stop after N RTC bogo operations
    inputBinding:
      position: 101
      prefix: --rtc-ops
  - id: sched
    type:
      - 'null'
      - string
    doc: set scheduler type
    inputBinding:
      position: 101
      prefix: --sched
  - id: sched_deadline
    type:
      - 'null'
      - int
    doc: set deadline for SCHED_DEADLINE to N nanosecs (Liunx only)
    inputBinding:
      position: 101
      prefix: --sched-deadline
  - id: sched_period
    type:
      - 'null'
      - int
    doc: set period for SCHED_DEADLINE to N nanosecs (Linux only)
    inputBinding:
      position: 101
      prefix: --sched-period
  - id: sched_prio
    type:
      - 'null'
      - int
    doc: set scheduler priority level N
    inputBinding:
      position: 101
      prefix: --sched-prio
  - id: sched_reclaim
    type:
      - 'null'
      - boolean
    doc: set reclaim cpu bandwidth for deadline scheduler (Liunx only)
    inputBinding:
      position: 101
      prefix: --sched-reclaim
  - id: sched_runtime
    type:
      - 'null'
      - int
    doc: set runtime for SCHED_DEADLINE to N nanosecs (Linux only)
    inputBinding:
      position: 101
      prefix: --sched-runtime
  - id: schedpolicy
    type:
      - 'null'
      - int
    doc: start N workers that exercise scheduling policy
    inputBinding:
      position: 101
      prefix: --schedpolicy
  - id: schedpolicy_ops
    type:
      - 'null'
      - int
    doc: stop after N scheduling policy bogo operations
    inputBinding:
      position: 101
      prefix: --schedpolicy-ops
  - id: sctp
    type:
      - 'null'
      - int
    doc: start N workers performing SCTP send/receives
    inputBinding:
      position: 101
      prefix: --sctp
  - id: sctp_domain
    type:
      - 'null'
      - string
    doc: specify sctp domain, default is ipv4
    inputBinding:
      position: 101
      prefix: --sctp-domain
  - id: sctp_ops
    type:
      - 'null'
      - int
    doc: stop after N SCTP bogo operations
    inputBinding:
      position: 101
      prefix: --sctp-ops
  - id: sctp_port
    type:
      - 'null'
      - int
    doc: use SCTP ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --sctp-port
  - id: sctp_sched
    type:
      - 'null'
      - string
    doc: specify sctp scheduler
    inputBinding:
      position: 101
      prefix: --sctp-sched
  - id: seal
    type:
      - 'null'
      - int
    doc: start N workers performing fcntl SEAL commands
    inputBinding:
      position: 101
      prefix: --seal
  - id: seal_ops
    type:
      - 'null'
      - int
    doc: stop after N SEAL bogo operations
    inputBinding:
      position: 101
      prefix: --seal-ops
  - id: seccomp
    type:
      - 'null'
      - int
    doc: start N workers performing seccomp call filtering
    inputBinding:
      position: 101
      prefix: --seccomp
  - id: seccomp_ops
    type:
      - 'null'
      - int
    doc: stop after N seccomp bogo operations
    inputBinding:
      position: 101
      prefix: --seccomp-ops
  - id: secretmem
    type:
      - 'null'
      - int
    doc: start N workers that use secretmem mappings
    inputBinding:
      position: 101
      prefix: --secretmem
  - id: secretmem_ops
    type:
      - 'null'
      - int
    doc: stop after N secretmem bogo operations
    inputBinding:
      position: 101
      prefix: --secretmem-ops
  - id: seek
    type:
      - 'null'
      - int
    doc: start N workers performing random seek r/w IO
    inputBinding:
      position: 101
      prefix: --seek
  - id: seek_ops
    type:
      - 'null'
      - int
    doc: stop after N seek bogo operations
    inputBinding:
      position: 101
      prefix: --seek-ops
  - id: seek_punch
    type:
      - 'null'
      - boolean
    doc: punch random holes in file to stress extents
    inputBinding:
      position: 101
      prefix: --seek-punch
  - id: seek_size
    type:
      - 'null'
      - int
    doc: length of file to do random I/O upon
    inputBinding:
      position: 101
      prefix: --seek-size
  - id: sem
    type:
      - 'null'
      - int
    doc: start N workers doing semaphore operations
    inputBinding:
      position: 101
      prefix: --sem
  - id: sem_ops
    type:
      - 'null'
      - int
    doc: stop after N semaphore bogo operations
    inputBinding:
      position: 101
      prefix: --sem-ops
  - id: sem_procs
    type:
      - 'null'
      - int
    doc: number of processes to start per worker
    inputBinding:
      position: 101
      prefix: --sem-procs
  - id: sem_sysv
    type:
      - 'null'
      - int
    doc: start N workers doing System V semaphore operations
    inputBinding:
      position: 101
      prefix: --sem-sysv
  - id: sem_sysv_ops
    type:
      - 'null'
      - int
    doc: stop after N System V sem bogo operations
    inputBinding:
      position: 101
      prefix: --sem-sysv-ops
  - id: sem_sysv_procs
    type:
      - 'null'
      - int
    doc: number of processes to start per worker
    inputBinding:
      position: 101
      prefix: --sem-sysv-procs
  - id: sendfile
    type:
      - 'null'
      - int
    doc: start N workers exercising sendfile
    inputBinding:
      position: 101
      prefix: --sendfile
  - id: sendfile_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo sendfile operations
    inputBinding:
      position: 101
      prefix: --sendfile-ops
  - id: sendfile_size
    type:
      - 'null'
      - int
    doc: size of data to be sent with sendfile
    inputBinding:
      position: 101
      prefix: --sendfile-size
  - id: sequential
    type:
      - 'null'
      - int
    doc: run all stressors one by one, invoking N of them
    inputBinding:
      position: 101
      prefix: --sequential
  - id: session
    type:
      - 'null'
      - int
    doc: start N workers that exercise new sessions
    inputBinding:
      position: 101
      prefix: --session
  - id: session_ops
    type:
      - 'null'
      - int
    doc: stop after N session bogo operations
    inputBinding:
      position: 101
      prefix: --session-ops
  - id: set
    type:
      - 'null'
      - int
    doc: start N workers exercising the set*() system calls
    inputBinding:
      position: 101
      prefix: --set
  - id: set_ops
    type:
      - 'null'
      - int
    doc: stop after N set bogo operations
    inputBinding:
      position: 101
      prefix: --set-ops
  - id: shellsort
    type:
      - 'null'
      - int
    doc: start N workers shell sorting 32 bit random integers
    inputBinding:
      position: 101
      prefix: --shellsort
  - id: shellsort_ops
    type:
      - 'null'
      - int
    doc: stop after N shell sort bogo operations
    inputBinding:
      position: 101
      prefix: --shellsort-ops
  - id: shellsort_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to sort
    inputBinding:
      position: 101
      prefix: --shellsort-size
  - id: shm
    type:
      - 'null'
      - int
    doc: start N workers that exercise POSIX shared memory
    inputBinding:
      position: 101
      prefix: --shm
  - id: shm_bytes
    type:
      - 'null'
      - int
    doc: allocate/free N bytes of POSIX shared memory
    inputBinding:
      position: 101
      prefix: --shm-bytes
  - id: shm_ops
    type:
      - 'null'
      - int
    doc: stop after N POSIX shared memory bogo operations
    inputBinding:
      position: 101
      prefix: --shm-ops
  - id: shm_segs
    type:
      - 'null'
      - int
    doc: allocate N POSIX shared memory segments per iteration
    inputBinding:
      position: 101
      prefix: --shm-segs
  - id: shm_sysv
    type:
      - 'null'
      - int
    doc: start N workers that exercise System V shared memory
    inputBinding:
      position: 101
      prefix: --shm-sysv
  - id: shm_sysv_bytes
    type:
      - 'null'
      - int
    doc: allocate and free N bytes of shared memory per loop
    inputBinding:
      position: 101
      prefix: --shm-sysv-bytes
  - id: shm_sysv_ops
    type:
      - 'null'
      - int
    doc: stop after N shared memory bogo operations
    inputBinding:
      position: 101
      prefix: --shm-sysv-ops
  - id: shm_sysv_segs
    type:
      - 'null'
      - int
    doc: allocate N shared memory segments per iteration
    inputBinding:
      position: 101
      prefix: --shm-sysv-segs
  - id: sigabrt
    type:
      - 'null'
      - int
    doc: start N workers generating segmentation faults
    inputBinding:
      position: 101
      prefix: --sigabrt
  - id: sigabrt_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo segmentation faults
    inputBinding:
      position: 101
      prefix: --sigabrt-ops
  - id: sigchld
    type:
      - 'null'
      - int
    doc: start N workers that handle SIGCHLD
    inputBinding:
      position: 101
      prefix: --sigchld
  - id: sigchld_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo SIGCHLD signals
    inputBinding:
      position: 101
      prefix: --sigchld-ops
  - id: sigfd
    type:
      - 'null'
      - int
    doc: start N workers reading signals via signalfd reads
    inputBinding:
      position: 101
      prefix: --sigfd
  - id: sigfd_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo signalfd reads
    inputBinding:
      position: 101
      prefix: --sigfd-ops
  - id: sigfpe
    type:
      - 'null'
      - int
    doc: start N workers generating floating point math faults
    inputBinding:
      position: 101
      prefix: --sigfpe
  - id: sigfpe_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo floating point math faults
    inputBinding:
      position: 101
      prefix: --sigfpe-ops
  - id: sigio
    type:
      - 'null'
      - int
    doc: start N workers that exercise SIGIO signals
    inputBinding:
      position: 101
      prefix: --sigio
  - id: sigio_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo sigio signals
    inputBinding:
      position: 101
      prefix: --sigio-ops
  - id: signal
    type:
      - 'null'
      - int
    doc: start N workers that exercise signal
    inputBinding:
      position: 101
      prefix: --signal
  - id: signal_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo signals
    inputBinding:
      position: 101
      prefix: --signal-ops
  - id: sigpending
    type:
      - 'null'
      - int
    doc: start N workers exercising sigpending
    inputBinding:
      position: 101
      prefix: --sigpending
  - id: sigpending_ops
    type:
      - 'null'
      - int
    doc: stop after N sigpending bogo operations
    inputBinding:
      position: 101
      prefix: --sigpending-ops
  - id: sigpipe
    type:
      - 'null'
      - int
    doc: start N workers exercising SIGPIPE
    inputBinding:
      position: 101
      prefix: --sigpipe
  - id: sigpipe_ops
    type:
      - 'null'
      - int
    doc: stop after N SIGPIPE bogo operations
    inputBinding:
      position: 101
      prefix: --sigpipe-ops
  - id: sigq
    type:
      - 'null'
      - int
    doc: start N workers sending sigqueue signals
    inputBinding:
      position: 101
      prefix: --sigq
  - id: sigq_ops
    type:
      - 'null'
      - int
    doc: stop after N sigqueue bogo operations
    inputBinding:
      position: 101
      prefix: --sigq-ops
  - id: sigrt
    type:
      - 'null'
      - int
    doc: start N workers sending real time signals
    inputBinding:
      position: 101
      prefix: --sigrt
  - id: sigrt_ops
    type:
      - 'null'
      - int
    doc: stop after N real time signal bogo operations
    inputBinding:
      position: 101
      prefix: --sigrt-ops
  - id: sigsegv
    type:
      - 'null'
      - int
    doc: start N workers generating segmentation faults
    inputBinding:
      position: 101
      prefix: --sigsegv
  - id: sigsegv_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo segmentation faults
    inputBinding:
      position: 101
      prefix: --sigsegv-ops
  - id: sigsuspend
    type:
      - 'null'
      - int
    doc: start N workers exercising sigsuspend
    inputBinding:
      position: 101
      prefix: --sigsuspend
  - id: sigsuspend_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo sigsuspend wakes
    inputBinding:
      position: 101
      prefix: --sigsuspend-ops
  - id: sigtrap
    type:
      - 'null'
      - int
    doc: start N workers generating segmentation faults
    inputBinding:
      position: 101
      prefix: --sigtrap
  - id: sigtrap_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo segmentation faults
    inputBinding:
      position: 101
      prefix: --sigtrap-ops
  - id: skiplist
    type:
      - 'null'
      - int
    doc: start N workers that exercise a skiplist search
    inputBinding:
      position: 101
      prefix: --skiplist
  - id: skiplist_ops
    type:
      - 'null'
      - int
    doc: stop after N skiplist search bogo operations
    inputBinding:
      position: 101
      prefix: --skiplist-ops
  - id: skiplist_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to add to skiplist
    inputBinding:
      position: 101
      prefix: --skiplist-size
  - id: sleep
    type:
      - 'null'
      - int
    doc: start N workers performing various duration sleeps
    inputBinding:
      position: 101
      prefix: --sleep
  - id: sleep_max
    type:
      - 'null'
      - int
    doc: create P threads at a time by each worker
    inputBinding:
      position: 101
      prefix: --sleep-max
  - id: sleep_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo sleep operations
    inputBinding:
      position: 101
      prefix: --sleep-ops
  - id: sock
    type:
      - 'null'
      - int
    doc: start N workers exercising socket I/O
    inputBinding:
      position: 101
      prefix: --sock
  - id: sock_domain
    type:
      - 'null'
      - string
    doc: specify socket domain, default is ipv4
    inputBinding:
      position: 101
      prefix: --sock-domain
  - id: sock_nodelay
    type:
      - 'null'
      - boolean
    doc: disable Nagle algorithm, send data immediately
    inputBinding:
      position: 101
      prefix: --sock-nodelay
  - id: sock_ops
    type:
      - 'null'
      - int
    doc: stop after N socket bogo operations
    inputBinding:
      position: 101
      prefix: --sock-ops
  - id: sock_opts
    type:
      - 'null'
      - string
    doc: socket options [send|sendmsg|sendmmsg]
    inputBinding:
      position: 101
      prefix: --sock-opts
  - id: sock_port
    type:
      - 'null'
      - int
    doc: use socket ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --sock-port
  - id: sock_type
    type:
      - 'null'
      - string
    doc: socket type (stream, seqpacket)
    inputBinding:
      position: 101
      prefix: --sock-type
  - id: sockdiag
    type:
      - 'null'
      - int
    doc: start N workers exercising sockdiag netlink
    inputBinding:
      position: 101
      prefix: --sockdiag
  - id: sockdiag_ops
    type:
      - 'null'
      - int
    doc: stop sockdiag workers after N bogo messages
    inputBinding:
      position: 101
      prefix: --sockdiag-ops
  - id: sockfd
    type:
      - 'null'
      - int
    doc: start N workers sending file descriptors over sockets
    inputBinding:
      position: 101
      prefix: --sockfd
  - id: sockfd_ops
    type:
      - 'null'
      - int
    doc: stop after N sockfd bogo operations
    inputBinding:
      position: 101
      prefix: --sockfd-ops
  - id: sockfd_port
    type:
      - 'null'
      - int
    doc: use socket fd ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --sockfd-port
  - id: sockmany
    type:
      - 'null'
      - int
    doc: start N workers exercising many socket connections
    inputBinding:
      position: 101
      prefix: --sockmany
  - id: sockmany_ops
    type:
      - 'null'
      - int
    doc: stop after N sockmany bogo operations
    inputBinding:
      position: 101
      prefix: --sockmany-ops
  - id: sockpair
    type:
      - 'null'
      - int
    doc: start N workers exercising socket pair I/O activity
    inputBinding:
      position: 101
      prefix: --sockpair
  - id: sockpair_ops
    type:
      - 'null'
      - int
    doc: stop after N socket pair bogo operations
    inputBinding:
      position: 101
      prefix: --sockpair-ops
  - id: softlockup
    type:
      - 'null'
      - int
    doc: start N workers that cause softlockups
    inputBinding:
      position: 101
      prefix: --softlockup
  - id: softlockup_ops
    type:
      - 'null'
      - int
    doc: stop after N softlockup bogo operations
    inputBinding:
      position: 101
      prefix: --softlockup-ops
  - id: spawn
    type:
      - 'null'
      - int
    doc: start N workers spawning stress-ng using posix_spawn
    inputBinding:
      position: 101
      prefix: --spawn
  - id: spawn_ops
    type:
      - 'null'
      - int
    doc: stop after N spawn bogo operations
    inputBinding:
      position: 101
      prefix: --spawn-ops
  - id: splice
    type:
      - 'null'
      - int
    doc: start N workers reading/writing using splice
    inputBinding:
      position: 101
      prefix: --splice
  - id: splice_bytes
    type:
      - 'null'
      - int
    doc: number of bytes to transfer per splice call
    inputBinding:
      position: 101
      prefix: --splice-bytes
  - id: splice_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo splice operations
    inputBinding:
      position: 101
      prefix: --splice-ops
  - id: stack
    type:
      - 'null'
      - int
    doc: start N workers generating stack overflows
    inputBinding:
      position: 101
      prefix: --stack
  - id: stack_fill
    type:
      - 'null'
      - boolean
    doc: fill stack, touches all new pages
    inputBinding:
      position: 101
      prefix: --stack-fill
  - id: stack_mlock
    type:
      - 'null'
      - boolean
    doc: mlock stack, force pages to be unswappable
    inputBinding:
      position: 101
      prefix: --stack-mlock
  - id: stack_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo stack overflows
    inputBinding:
      position: 101
      prefix: --stack-ops
  - id: stackmmap
    type:
      - 'null'
      - int
    doc: start N workers exercising a filebacked stack
    inputBinding:
      position: 101
      prefix: --stackmmap
  - id: stackmmap_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo stackmmap operations
    inputBinding:
      position: 101
      prefix: --stackmmap-ops
  - id: str
    type:
      - 'null'
      - int
    doc: start N workers exercising lib C string functions
    inputBinding:
      position: 101
      prefix: --str
  - id: str_method
    type:
      - 'null'
      - string
    doc: specify the string function to stress
    inputBinding:
      position: 101
      prefix: --str-method
  - id: str_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo string operations
    inputBinding:
      position: 101
      prefix: --str-ops
  - id: stream
    type:
      - 'null'
      - int
    doc: start N workers exercising memory bandwidth
    inputBinding:
      position: 101
      prefix: --stream
  - id: stream_index
    type:
      - 'null'
      - boolean
    doc: specify number of indices into the data (0..3)
    inputBinding:
      position: 101
      prefix: --stream-index
  - id: stream_l3_size
    type:
      - 'null'
      - int
    doc: specify the L3 cache size of the CPU
    inputBinding:
      position: 101
      prefix: --stream-l3-size
  - id: stream_madvise
    type:
      - 'null'
      - string
    doc: specify mmap'd stream buffer madvise advice
    inputBinding:
      position: 101
      prefix: --stream-madvise
  - id: stream_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo stream operations
    inputBinding:
      position: 101
      prefix: --stream-ops
  - id: stressors
    type:
      - 'null'
      - boolean
    doc: show available stress tests
    inputBinding:
      position: 101
      prefix: --stressors
  - id: swap
    type:
      - 'null'
      - int
    doc: start N workers exercising swapon/swapoff
    inputBinding:
      position: 101
      prefix: --swap
  - id: swap_ops
    type:
      - 'null'
      - int
    doc: stop after N swapon/swapoff operations
    inputBinding:
      position: 101
      prefix: --swap-ops
  - id: switch
    type:
      - 'null'
      - int
    doc: start N workers doing rapid context switches
    inputBinding:
      position: 101
      prefix: --switch
  - id: switch_freq
    type:
      - 'null'
      - int
    doc: set frequency of context switches
    inputBinding:
      position: 101
      prefix: --switch-freq
  - id: switch_ops
    type:
      - 'null'
      - int
    doc: stop after N context switch bogo operations
    inputBinding:
      position: 101
      prefix: --switch-ops
  - id: symlink
    type:
      - 'null'
      - int
    doc: start N workers creating symbolic links
    inputBinding:
      position: 101
      prefix: --symlink
  - id: symlink_ops
    type:
      - 'null'
      - int
    doc: stop after N symbolic link bogo operations
    inputBinding:
      position: 101
      prefix: --symlink-ops
  - id: sync_file
    type:
      - 'null'
      - int
    doc: start N workers exercise sync_file_range
    inputBinding:
      position: 101
      prefix: --sync-file
  - id: sync_file_bytes
    type:
      - 'null'
      - int
    doc: size of file to be sync'd
    inputBinding:
      position: 101
      prefix: --sync-file-bytes
  - id: sync_file_ops
    type:
      - 'null'
      - int
    doc: stop after N sync_file_range bogo operations
    inputBinding:
      position: 101
      prefix: --sync-file-ops
  - id: sysbadaddr
    type:
      - 'null'
      - int
    doc: start N workers that pass bad addresses to syscalls
    inputBinding:
      position: 101
      prefix: --sysbadaddr
  - id: sysbadaddr_ops
    type:
      - 'null'
      - int
    doc: stop after N sysbadaddr bogo syscalls
    inputBinding:
      position: 101
      prefix: --sysbadaddr-ops
  - id: sysfs
    type:
      - 'null'
      - int
    doc: start N workers reading files from /sys
    inputBinding:
      position: 101
      prefix: --sysfs
  - id: sysfs_ops
    type:
      - 'null'
      - int
    doc: stop after sysfs bogo operations
    inputBinding:
      position: 101
      prefix: --sysfs-ops
  - id: sysinfo
    type:
      - 'null'
      - int
    doc: start N workers reading system information
    inputBinding:
      position: 101
      prefix: --sysinfo
  - id: sysinfo_ops
    type:
      - 'null'
      - int
    doc: stop after sysinfo bogo operations
    inputBinding:
      position: 101
      prefix: --sysinfo-ops
  - id: sysinval
    type:
      - 'null'
      - int
    doc: start N workers that pass invalid args to syscalls
    inputBinding:
      position: 101
      prefix: --sysinval
  - id: sysinval_ops
    type:
      - 'null'
      - int
    doc: stop after N sysinval bogo syscalls
    inputBinding:
      position: 101
      prefix: --sysinval-ops
  - id: syslog
    type:
      - 'null'
      - boolean
    doc: log messages to the syslog
    inputBinding:
      position: 101
      prefix: --syslog
  - id: taskset
    type:
      - 'null'
      - boolean
    doc: use specific CPUs (set CPU affinity)
    inputBinding:
      position: 101
      prefix: --taskset
  - id: tee
    type:
      - 'null'
      - int
    doc: start N workers exercising the tee system call
    inputBinding:
      position: 101
      prefix: --tee
  - id: tee_ops
    type:
      - 'null'
      - int
    doc: stop after N tee bogo operations
    inputBinding:
      position: 101
      prefix: --tee-ops
  - id: temp_path
    type:
      - 'null'
      - Directory
    doc: specify path for temporary directories and files
    inputBinding:
      position: 101
      prefix: --temp-path
  - id: thrash
    type:
      - 'null'
      - boolean
    doc: force all pages in causing swap thrashing
    inputBinding:
      position: 101
      prefix: --thrash
  - id: timeout
    type:
      - 'null'
      - int
    doc: timeout after T seconds
    inputBinding:
      position: 101
      prefix: --timeout
  - id: timer
    type:
      - 'null'
      - int
    doc: start N workers producing timer events
    inputBinding:
      position: 101
      prefix: --timer
  - id: timer_freq
    type:
      - 'null'
      - int
    doc: run timer(s) at F Hz, range 1 to 1000000000
    inputBinding:
      position: 101
      prefix: --timer-freq
  - id: timer_ops
    type:
      - 'null'
      - int
    doc: stop after N timer bogo events
    inputBinding:
      position: 101
      prefix: --timer-ops
  - id: timer_rand
    type:
      - 'null'
      - boolean
    doc: enable random timer frequency
    inputBinding:
      position: 101
      prefix: --timer-rand
  - id: timer_slack
    type:
      - 'null'
      - boolean
    doc: enable timer slack mode
    inputBinding:
      position: 101
      prefix: --timer-slack
  - id: timerfd
    type:
      - 'null'
      - int
    doc: start N workers producing timerfd events
    inputBinding:
      position: 101
      prefix: --timerfd
  - id: timerfd_freq
    type:
      - 'null'
      - int
    doc: run timer(s) at F Hz, range 1 to 1000000000
    inputBinding:
      position: 101
      prefix: --timerfd-freq
  - id: timerfd_ops
    type:
      - 'null'
      - int
    doc: stop after N timerfd bogo events
    inputBinding:
      position: 101
      prefix: --timerfd-ops
  - id: timerfd_rand
    type:
      - 'null'
      - boolean
    doc: enable random timerfd frequency
    inputBinding:
      position: 101
      prefix: --timerfd-rand
  - id: times
    type:
      - 'null'
      - boolean
    doc: show run time summary at end of the run
    inputBinding:
      position: 101
      prefix: --times
  - id: timestamp
    type:
      - 'null'
      - boolean
    doc: timestamp log output
    inputBinding:
      position: 101
      prefix: --timestamp
  - id: tlb_shootdown
    type:
      - 'null'
      - int
    doc: start N workers that force TLB shootdowns
    inputBinding:
      position: 101
      prefix: --tlb-shootdown
  - id: tlb_shootdown_ops
    type:
      - 'null'
      - int
    doc: stop after N TLB shootdown bogo ops
    inputBinding:
      position: 101
      prefix: --tlb-shootdown-ops
  - id: tmpfs
    type:
      - 'null'
      - int
    doc: start N workers mmap'ing a file on tmpfs
    inputBinding:
      position: 101
      prefix: --tmpfs
  - id: tmpfs_mmap_async
    type:
      - 'null'
      - boolean
    doc: using asynchronous msyncs for tmpfs file based mmap
    inputBinding:
      position: 101
      prefix: --tmpfs-mmap-async
  - id: tmpfs_mmap_file
    type:
      - 'null'
      - boolean
    doc: mmap onto a tmpfs file using synchronous msyncs
    inputBinding:
      position: 101
      prefix: --tmpfs-mmap-file
  - id: tmpfs_ops
    type:
      - 'null'
      - int
    doc: stop after N tmpfs bogo ops
    inputBinding:
      position: 101
      prefix: --tmpfs-ops
  - id: tree
    type:
      - 'null'
      - int
    doc: start N workers that exercise tree structures
    inputBinding:
      position: 101
      prefix: --tree
  - id: tree_method
    type:
      - 'null'
      - string
    doc: select tree method, all,avl,binary,rb,splay
    inputBinding:
      position: 101
      prefix: --tree-method
  - id: tree_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo tree operations
    inputBinding:
      position: 101
      prefix: --tree-ops
  - id: tree_size
    type:
      - 'null'
      - int
    doc: N is the number of items in the tree
    inputBinding:
      position: 101
      prefix: --tree-size
  - id: tsc
    type:
      - 'null'
      - int
    doc: start N workers reading the time stamp counter
    inputBinding:
      position: 101
      prefix: --tsc
  - id: tsc_ops
    type:
      - 'null'
      - int
    doc: stop after N TSC bogo operations
    inputBinding:
      position: 101
      prefix: --tsc-ops
  - id: tsearch
    type:
      - 'null'
      - int
    doc: start N workers that exercise a tree search
    inputBinding:
      position: 101
      prefix: --tsearch
  - id: tsearch_ops
    type:
      - 'null'
      - int
    doc: stop after N tree search bogo operations
    inputBinding:
      position: 101
      prefix: --tsearch-ops
  - id: tsearch_size
    type:
      - 'null'
      - int
    doc: number of 32 bit integers to tsearch
    inputBinding:
      position: 101
      prefix: --tsearch-size
  - id: tun
    type:
      - 'null'
      - int
    doc: start N workers exercising tun interface
    inputBinding:
      position: 101
      prefix: --tun
  - id: tun_ops
    type:
      - 'null'
      - int
    doc: stop after N tun bogo operations
    inputBinding:
      position: 101
      prefix: --tun-ops
  - id: tun_tap
    type:
      - 'null'
      - boolean
    doc: use TAP interface instead of TUN
    inputBinding:
      position: 101
      prefix: --tun-tap
  - id: tz
    type:
      - 'null'
      - boolean
    doc: collect temperatures from thermal zones (Linux only)
    inputBinding:
      position: 101
      prefix: --tz
  - id: udp
    type:
      - 'null'
      - int
    doc: start N workers performing UDP send/receives
    inputBinding:
      position: 101
      prefix: --udp
  - id: udp_domain
    type:
      - 'null'
      - string
    doc: specify domain, default is ipv4
    inputBinding:
      position: 101
      prefix: --udp-domain
  - id: udp_flood
    type:
      - 'null'
      - int
    doc: start N workers that performs a UDP flood attack
    inputBinding:
      position: 101
      prefix: --udp-flood
  - id: udp_flood_domain
    type:
      - 'null'
      - string
    doc: specify domain, default is ipv4
    inputBinding:
      position: 101
      prefix: --udp-flood-domain
  - id: udp_flood_ops
    type:
      - 'null'
      - int
    doc: stop after N udp flood bogo operations
    inputBinding:
      position: 101
      prefix: --udp-flood-ops
  - id: udp_lite
    type:
      - 'null'
      - boolean
    doc: use the UDP-Lite (RFC 3828) protocol
    inputBinding:
      position: 101
      prefix: --udp-lite
  - id: udp_ops
    type:
      - 'null'
      - int
    doc: stop after N udp bogo operations
    inputBinding:
      position: 101
      prefix: --udp-ops
  - id: udp_port
    type:
      - 'null'
      - int
    doc: use ports P to P + number of workers - 1
    inputBinding:
      position: 101
      prefix: --udp-port
  - id: unshare
    type:
      - 'null'
      - int
    doc: start N workers exercising resource unsharing
    inputBinding:
      position: 101
      prefix: --unshare
  - id: unshare_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo unshare operations
    inputBinding:
      position: 101
      prefix: --unshare-ops
  - id: uprobe
    type:
      - 'null'
      - int
    doc: start N workers that generate uprobe events
    inputBinding:
      position: 101
      prefix: --uprobe
  - id: uprobe_ops
    type:
      - 'null'
      - int
    doc: stop after N uprobe events
    inputBinding:
      position: 101
      prefix: --uprobe-ops
  - id: urandom
    type:
      - 'null'
      - int
    doc: start N workers reading /dev/urandom
    inputBinding:
      position: 101
      prefix: --urandom
  - id: urandom_ops
    type:
      - 'null'
      - int
    doc: stop after N urandom bogo read operations
    inputBinding:
      position: 101
      prefix: --urandom-ops
  - id: userfaultfd
    type:
      - 'null'
      - int
    doc: start N page faulting workers with userspace handling
    inputBinding:
      position: 101
      prefix: --userfaultfd
  - id: userfaultfd_ops
    type:
      - 'null'
      - int
    doc: stop after N page faults have been handled
    inputBinding:
      position: 101
      prefix: --userfaultfd-ops
  - id: utime
    type:
      - 'null'
      - int
    doc: start N workers updating file timestamps
    inputBinding:
      position: 101
      prefix: --utime
  - id: utime_fsync
    type:
      - 'null'
      - boolean
    doc: force utime meta data sync to the file system
    inputBinding:
      position: 101
      prefix: --utime-fsync
  - id: utime_ops
    type:
      - 'null'
      - int
    doc: stop after N utime bogo operations
    inputBinding:
      position: 101
      prefix: --utime-ops
  - id: vdso
    type:
      - 'null'
      - int
    doc: start N workers exercising functions in the VDSO
    inputBinding:
      position: 101
      prefix: --vdso
  - id: vdso_func
    type:
      - 'null'
      - string
    doc: use just vDSO function F
    inputBinding:
      position: 101
      prefix: --vdso-func
  - id: vdso_ops
    type:
      - 'null'
      - int
    doc: stop after N vDSO function calls
    inputBinding:
      position: 101
      prefix: --vdso-ops
  - id: vecmath
    type:
      - 'null'
      - int
    doc: start N workers performing vector math ops
    inputBinding:
      position: 101
      prefix: --vecmath
  - id: vecmath_ops
    type:
      - 'null'
      - int
    doc: stop after N vector math bogo operations
    inputBinding:
      position: 101
      prefix: --vecmath-ops
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: verify
    type:
      - 'null'
      - boolean
    doc: verify results (not available on all tests)
    inputBinding:
      position: 101
      prefix: --verify
  - id: verity
    type:
      - 'null'
      - int
    doc: start N workers exercising file verity ioctls
    inputBinding:
      position: 101
      prefix: --verity
  - id: verity_ops
    type:
      - 'null'
      - int
    doc: stop after N file verity bogo operations
    inputBinding:
      position: 101
      prefix: --verity-ops
  - id: vfork
    type:
      - 'null'
      - int
    doc: start N workers spinning on vfork() and exit()
    inputBinding:
      position: 101
      prefix: --vfork
  - id: vfork_max
    type:
      - 'null'
      - int
    doc: create P processes per iteration, default is 1
    inputBinding:
      position: 101
      prefix: --vfork-max
  - id: vfork_ops
    type:
      - 'null'
      - int
    doc: stop after N vfork bogo operations
    inputBinding:
      position: 101
      prefix: --vfork-ops
  - id: vforkmany
    type:
      - 'null'
      - int
    doc: start N workers spawning many vfork children
    inputBinding:
      position: 101
      prefix: --vforkmany
  - id: vforkmany_ops
    type:
      - 'null'
      - int
    doc: stop after spawning N vfork children
    inputBinding:
      position: 101
      prefix: --vforkmany-ops
  - id: vm
    type:
      - 'null'
      - int
    doc: start N workers spinning on anonymous mmap
    inputBinding:
      position: 101
      prefix: --vm
  - id: vm_addr
    type:
      - 'null'
      - int
    doc: start N vm address exercising workers
    inputBinding:
      position: 101
      prefix: --vm-addr
  - id: vm_addr_ops
    type:
      - 'null'
      - int
    doc: stop after N vm address bogo operations
    inputBinding:
      position: 101
      prefix: --vm-addr-ops
  - id: vm_bytes
    type:
      - 'null'
      - int
    doc: allocate N bytes per vm worker (default 256MB)
    inputBinding:
      position: 101
      prefix: --vm-bytes
  - id: vm_hang
    type:
      - 'null'
      - int
    doc: sleep N seconds before freeing memory
    inputBinding:
      position: 101
      prefix: --vm-hang
  - id: vm_keep
    type:
      - 'null'
      - boolean
    doc: redirty memory instead of reallocating
    inputBinding:
      position: 101
      prefix: --vm-keep
  - id: vm_locked
    type:
      - 'null'
      - boolean
    doc: lock the pages of the mapped region into memory
    inputBinding:
      position: 101
      prefix: --vm-locked
  - id: vm_madvise
    type:
      - 'null'
      - string
    doc: specify mmap'd vm buffer madvise advice
    inputBinding:
      position: 101
      prefix: --vm-madvise
  - id: vm_method
    type:
      - 'null'
      - string
    doc: specify stress vm method M, default is all
    inputBinding:
      position: 101
      prefix: --vm-method
  - id: vm_ops
    type:
      - 'null'
      - int
    doc: stop after N vm bogo operations
    inputBinding:
      position: 101
      prefix: --vm-ops
  - id: vm_populate
    type:
      - 'null'
      - boolean
    doc: populate (prefault) page tables for a mapping
    inputBinding:
      position: 101
      prefix: --vm-populate
  - id: vm_rw
    type:
      - 'null'
      - int
    doc: start N vm read/write process_vm* copy workers
    inputBinding:
      position: 101
      prefix: --vm-rw
  - id: vm_rw_bytes
    type:
      - 'null'
      - int
    doc: transfer N bytes of memory per bogo operation
    inputBinding:
      position: 101
      prefix: --vm-rw-bytes
  - id: vm_rw_ops
    type:
      - 'null'
      - int
    doc: stop after N vm process_vm* copy bogo operations
    inputBinding:
      position: 101
      prefix: --vm-rw-ops
  - id: vm_segv
    type:
      - 'null'
      - int
    doc: start N workers that unmap their address space
    inputBinding:
      position: 101
      prefix: --vm-segv
  - id: vm_segv_ops
    type:
      - 'null'
      - int
    doc: stop after N vm-segv unmap'd SEGV faults
    inputBinding:
      position: 101
      prefix: --vm-segv-ops
  - id: vm_splice
    type:
      - 'null'
      - int
    doc: start N workers reading/writing using vmsplice
    inputBinding:
      position: 101
      prefix: --vm-splice
  - id: vm_splice_bytes
    type:
      - 'null'
      - int
    doc: number of bytes to transfer per vmsplice call
    inputBinding:
      position: 101
      prefix: --vm-splice-bytes
  - id: vm_splice_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo splice operations
    inputBinding:
      position: 101
      prefix: --vm-splice-ops
  - id: wait
    type:
      - 'null'
      - int
    doc: start N workers waiting on child being stop/resumed
    inputBinding:
      position: 101
      prefix: --wait
  - id: wait_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo wait operations
    inputBinding:
      position: 101
      prefix: --wait-ops
  - id: watchdog
    type:
      - 'null'
      - int
    doc: start N workers that exercise /dev/watchdog
    inputBinding:
      position: 101
      prefix: --watchdog
  - id: watchdog_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo watchdog operations
    inputBinding:
      position: 101
      prefix: --watchdog-ops
  - id: wcs
    type:
      - 'null'
      - int
    doc: start N workers on lib C wide char string functions
    inputBinding:
      position: 101
      prefix: --wcs
  - id: wcs_method
    type:
      - 'null'
      - string
    doc: specify the wide character string function to stress
    inputBinding:
      position: 101
      prefix: --wcs-method
  - id: wcs_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo wide character string operations
    inputBinding:
      position: 101
      prefix: --wcs-ops
  - id: x86syscall
    type:
      - 'null'
      - int
    doc: start N workers exercising functions using syscall
    inputBinding:
      position: 101
      prefix: --x86syscall
  - id: x86syscall_func
    type:
      - 'null'
      - string
    doc: use just syscall function F
    inputBinding:
      position: 101
      prefix: --x86syscall-func
  - id: x86syscall_ops
    type:
      - 'null'
      - int
    doc: stop after N syscall function calls
    inputBinding:
      position: 101
      prefix: --x86syscall-ops
  - id: xattr
    type:
      - 'null'
      - int
    doc: start N workers stressing file extended attributes
    inputBinding:
      position: 101
      prefix: --xattr
  - id: xattr_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo xattr operations
    inputBinding:
      position: 101
      prefix: --xattr-ops
  - id: yaml
    type:
      - 'null'
      - File
    doc: output results to YAML formatted filed
    inputBinding:
      position: 101
      prefix: --yaml
  - id: yield
    type:
      - 'null'
      - int
    doc: start N workers doing sched_yield() calls
    inputBinding:
      position: 101
      prefix: --yield
  - id: yield_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo yield operations
    inputBinding:
      position: 101
      prefix: --yield-ops
  - id: zero
    type:
      - 'null'
      - int
    doc: start N workers reading /dev/zero
    inputBinding:
      position: 101
      prefix: --zero
  - id: zero_ops
    type:
      - 'null'
      - int
    doc: stop after N /dev/zero bogo read operations
    inputBinding:
      position: 101
      prefix: --zero-ops
  - id: zlib
    type:
      - 'null'
      - int
    doc: start N workers compressing data with zlib
    inputBinding:
      position: 101
      prefix: --zlib
  - id: zlib_level
    type:
      - 'null'
      - int
    doc: specify zlib compression level 0=fast, 9=best
    inputBinding:
      position: 101
      prefix: --zlib-level
  - id: zlib_mem_level
    type:
      - 'null'
      - int
    doc: specify zlib compression state memory usage 1=minimum, 9=maximum
    inputBinding:
      position: 101
      prefix: --zlib-mem-level
  - id: zlib_method
    type:
      - 'null'
      - string
    doc: specify zlib random data generation method M
    inputBinding:
      position: 101
      prefix: --zlib-method
  - id: zlib_ops
    type:
      - 'null'
      - int
    doc: stop after N zlib bogo compression operations
    inputBinding:
      position: 101
      prefix: --zlib-ops
  - id: zlib_strategy
    type:
      - 'null'
      - string
    doc: specify zlib strategy 0=default, 1=filtered, 2=huffman only, 3=rle, 
      4=fixed
    inputBinding:
      position: 101
      prefix: --zlib-strategy
  - id: zlib_stream_bytes
    type:
      - 'null'
      - int
    doc: specify the number of bytes to deflate until the current stream will be
      closed
    inputBinding:
      position: 101
      prefix: --zlib-stream-bytes
  - id: zlib_window_bits
    type:
      - 'null'
      - int
    doc: specify zlib window bits -8-(-15) | 8-15 | 24-31 | 40-47
    inputBinding:
      position: 101
      prefix: --zlib-window-bits
  - id: zombie
    type:
      - 'null'
      - int
    doc: start N workers that rapidly create and reap zombies
    inputBinding:
      position: 101
      prefix: --zombie
  - id: zombie_max
    type:
      - 'null'
      - int
    doc: set upper limit of N zombies per worker
    inputBinding:
      position: 101
      prefix: --zombie-max
  - id: zombie_ops
    type:
      - 'null'
      - int
    doc: stop after N bogo zombie fork operations
    inputBinding:
      position: 101
      prefix: --zombie-ops
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stress-ng:0.12.04
stdout: stress-ng.out
