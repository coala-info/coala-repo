cwlVersion: v1.2
class: CommandLineTool
baseCommand: ymp submit
label: ymp_submit
doc: "Build target(s) on cluster\n\nTool homepage: https://ymp.readthedocs.io"
inputs:
  - id: target_files
    type:
      type: array
      items: File
    doc: Target files to build
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - string
    doc: "Additional arguments passed to cluster submission command. Note: Make sure
      the first character of the argument is not '-', prefix with ' ' as necessary."
    inputBinding:
      position: 102
      prefix: --args
  - id: command
    type:
      - 'null'
      - string
    doc: Use CMD to submit job script to the cluster
    inputBinding:
      position: 102
      prefix: --command
  - id: cores
    type:
      - 'null'
      - int
    doc: Maximum number of cluster cores to use
    inputBinding:
      position: 102
      prefix: --cores
  - id: drmaa
    type:
      - 'null'
      - boolean
    doc: 'Use DRMAA to submit jobs to cluster. Note: Make sure you have a working
      DRMAA library. Set DRMAA_LIBRAY_PATH if necessary.'
    inputBinding:
      position: 102
      prefix: --drmaa
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Only show what would be done
    inputBinding:
      position: 102
      prefix: --dryrun
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force rebuilding of target
    inputBinding:
      position: 102
      prefix: --force
  - id: forceall
    type:
      - 'null'
      - boolean
    doc: Force rebuilding of all stages leading to target
    inputBinding:
      position: 102
      prefix: --forceall
  - id: immediate
    type:
      - 'null'
      - boolean
    doc: Use immediate submission, submitting all jobs to the cluster at once.
    inputBinding:
      position: 102
      prefix: --immediate
  - id: latency_wait
    type:
      - 'null'
      - int
    doc: Time in seconds to wait after job completed until files are expected to
      have appeared in local file system view. On NFS, this time is governed by 
      the acdirmax mount option, which defaults to 60 seconds.
    inputBinding:
      position: 102
      prefix: --latency-wait
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Number of local threads to use
    inputBinding:
      position: 102
      prefix: --local-cores
  - id: lock
    type:
      - 'null'
      - boolean
    doc: Use locking to prevent clobbering of files by parallel instances of YMP
      running
    inputBinding:
      position: 102
      prefix: --lock
  - id: log_file
    type:
      - 'null'
      - string
    doc: Specify a log file
    inputBinding:
      position: 102
      prefix: --log-file
  - id: max_jobs_per_second
    type:
      - 'null'
      - int
    doc: Limit the number of jobs submitted per second
    inputBinding:
      position: 102
      prefix: --max-jobs-per-second
  - id: no_lock
    type:
      - 'null'
      - boolean
    doc: Don't use locking to prevent clobbering of files by parallel instances 
      of YMP running
    inputBinding:
      position: 102
      prefix: --no-lock
  - id: nodes
    type:
      - 'null'
      - int
    doc: Limit the maximum number of jobs submitted at a time. Note that this 
      does not imply a maximum core count or running job count, but simply 
      limits the number of queued jobs.
    inputBinding:
      position: 102
      prefix: --nodes
  - id: nohup
    type:
      - 'null'
      - boolean
    doc: Don't die once the terminal goes away.
    inputBinding:
      position: 102
      prefix: --nohup
  - id: notemp
    type:
      - 'null'
      - boolean
    doc: Do not remove temporary files
    inputBinding:
      position: 102
      prefix: --notemp
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on uncaught exception
    inputBinding:
      position: 102
      prefix: --pdb
  - id: printshellcmds
    type:
      - 'null'
      - boolean
    doc: Print shell commands to be executed on shell
    inputBinding:
      position: 102
      prefix: --printshellcmds
  - id: profile
    type:
      - 'null'
      - string
    doc: Select cluster config profile to use. Overrides cluster.profile setting
      from config.
    inputBinding:
      position: 102
      prefix: --profile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease log verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reason
    type:
      - 'null'
      - boolean
    doc: Print reason for executing rule
    inputBinding:
      position: 102
      prefix: --reason
  - id: rerun_incomplete
    type:
      - 'null'
      - boolean
    doc: Re-run jobs left incomplete in last run
    inputBinding:
      position: 102
      prefix: --ri
  - id: rerun_triggers
    type:
      - 'null'
      - type: array
        items: string
    doc: Select reasons for reruns. Default changed from Snakemake toonly mtime 
      for performance reasons.
    default: mtime
    inputBinding:
      position: 102
      prefix: --rerun-triggers
  - id: scheduler
    type:
      - 'null'
      - string
    doc: ILP or greedy
    inputBinding:
      position: 102
      prefix: --scheduler
  - id: scriptname
    type:
      - 'null'
      - string
    doc: Set the name template used for submitted jobs
    inputBinding:
      position: 102
      prefix: --scriptname
  - id: shadow_prefix
    type:
      - 'null'
      - Directory
    doc: Directory to place data for shadowed rules
    inputBinding:
      position: 102
      prefix: --shadow-prefix
  - id: snake_config
    type:
      - 'null'
      - File
    doc: Provide snakemake cluster config file
    inputBinding:
      position: 102
      prefix: --snake-config
  - id: sync
    type:
      - 'null'
      - boolean
    doc: Use synchronous cluster submission, keeping the submit command running 
      until the job has completed. Adds qsub_sync_arg to cluster command
    inputBinding:
      position: 102
      prefix: --sync
  - id: touch
    type:
      - 'null'
      - boolean
    doc: Only touch files, faking update
    inputBinding:
      position: 102
      prefix: --touch
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase log verbosity
    inputBinding:
      position: 102
      prefix: --verbose
  - id: wrapper
    type:
      - 'null'
      - string
    doc: Use CMD as script submitted to the cluster. See Snakemake documentation
      for more information.
    inputBinding:
      position: 102
      prefix: --wrapper
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_submit.out
