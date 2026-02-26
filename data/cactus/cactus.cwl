cwlVersion: v1.2
class: CommandLineTool
baseCommand: cactus
label: cactus
doc: "A pipeline for whole-genome alignment and analysis.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus"
inputs:
  - id: job_store
    type: string
    doc: Store in which to place job management files and the global accessed 
      temporary files. Job store locator strings should be formatted as follows 
      aws:<AWS region>:<name prefix> azure:<account>:<name prefix>' 
      google:<project id>:<name prefix> file:<file path> Note that for backwards
      compatibility ./foo is equivalent to file:/foo and /bar is equivalent to 
      file:/bar. (If this is a file path this needs to be globally accessible by
      all machines running jobs). If the store already exists and restart is 
      false a JobStoreCreationException exception will be thrown.
    inputBinding:
      position: 1
  - id: seq_file
    type: File
    doc: Seq file
    inputBinding:
      position: 2
  - id: output_hal
    type: File
    doc: Output HAL file
    inputBinding:
      position: 3
  - id: alpha_packing
    type:
      - 'null'
      - float
    doc: default=0.8
    default: 0.8
    inputBinding:
      position: 104
      prefix: --alphaPacking
  - id: bad_worker
    type:
      - 'null'
      - float
    doc: For testing purposes randomly kill 'badWorker' proportion of jobs using
      SIGKILL, default=0.0
    default: 0.0
    inputBinding:
      position: 104
      prefix: --badWorker
  - id: bad_worker_fail_interval
    type:
      - 'null'
      - float
    doc: When killing the job pick uniformly within the interval from 0.0 to 
      'badWorkerFailInterval' seconds after the worker starts, default=0.01
    default: 0.01
    inputBinding:
      position: 104
      prefix: --badWorkerFailInterval
  - id: batch_system
    type:
      - 'null'
      - string
    doc: The type of batch system to run the job(s) with, currently can be one 
      of singleMachine, parasol, gridEngine, lsf or mesos'. 
      default=singleMachine
    default: singleMachine
    inputBinding:
      position: 104
      prefix: --batchSystem
  - id: beta_inertia
    type:
      - 'null'
      - float
    doc: default=1.2
    default: 1.2
    inputBinding:
      position: 104
      prefix: --betaInertia
  - id: binaries_mode
    type:
      - 'null'
      - string
    doc: The way to run the Cactus binaries
    inputBinding:
      position: 104
      prefix: --binariesMode
  - id: build_avgs
    type:
      - 'null'
      - boolean
    doc: Build trees
    inputBinding:
      position: 104
      prefix: --buildAvgs
  - id: build_fasta
    type:
      - 'null'
      - boolean
    doc: Build a fasta file of the input sequences (and reference sequence, used
      with hal output)
    inputBinding:
      position: 104
      prefix: --buildFasta
  - id: build_hal
    type:
      - 'null'
      - boolean
    doc: Build a hal file
    inputBinding:
      position: 104
      prefix: --buildHal
  - id: build_reference
    type:
      - 'null'
      - boolean
    doc: Creates a reference ordering for the flowers
    inputBinding:
      position: 104
      prefix: --buildReference
  - id: clean
    type:
      - 'null'
      - string
    doc: "Determines the deletion of the jobStore upon completion of the program.
      Choices: 'always', 'onError','never', 'onSuccess'. The --stats option requires
      information from the jobStore upon completion so the jobStore will never be
      deleted with that flag. If you wish to be able to restart the run, choose 'never'
      or 'onSuccess'. Default is 'never' if stats is enabled, and 'onSuccess' otherwise"
    default: onSuccess
    inputBinding:
      position: 104
      prefix: --clean
  - id: clean_work_dir
    type:
      - 'null'
      - string
    doc: "Determines deletion of temporary worker directory upon completion of a job.
      Choices: 'always', 'never', 'onSuccess'. Default = always. WARNING: This option
      should be changed for debugging only. Running a full pipeline with this option
      could fill your disk with intermediate data."
    default: always
    inputBinding:
      position: 104
      prefix: --cleanWorkDir
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify cactus configuration file
    inputBinding:
      position: 104
      prefix: --configFile
  - id: container_image
    type:
      - 'null'
      - string
    doc: Use the the specified pre-built containter image rather than pulling 
      one from quay.io
    inputBinding:
      position: 104
      prefix: --containerImage
  - id: cse_key
    type:
      - 'null'
      - File
    doc: Path to file containing 256-bit key to be used for client-side 
      encryption on azureJobStore. By default, no encryption is used.
    inputBinding:
      position: 104
      prefix: --cseKey
  - id: database
    type:
      - 'null'
      - string
    doc: 'Database type: tokyo_cabinet or kyoto_tycoon [default: kyoto_tycoon]'
    default: kyoto_tycoon
    inputBinding:
      position: 104
      prefix: --database
  - id: default_cores
    type:
      - 'null'
      - float
    doc: The default number of CPU cores to dedicate a job. Only applicable to 
      jobs that do not specify an explicit value for this requirement. Fractions
      of a core (for example 0.1) are supported on some batch systems, namely 
      Mesos and singleMachine. Default is 1.0
    default: 1.0
    inputBinding:
      position: 104
      prefix: --defaultCores
  - id: default_disk
    type:
      - 'null'
      - string
    doc: The default amount of disk space to dedicate a job. Only applicable to 
      jobs that do not specify an explicit value for this requirement. Standard 
      suffixes like K, Ki, M, Mi, G or Gi are supported. Default is 2.0 Gi
    default: 2.0 Gi
    inputBinding:
      position: 104
      prefix: --defaultDisk
  - id: default_memory
    type:
      - 'null'
      - string
    doc: The default amount of memory to request for a job. Only applicable to 
      jobs that do not specify an explicit value for this requirement. Standard 
      suffixes like K, Ki, M, Mi, G or Gi are supported. Default is 2.0 Gi
    default: 2.0 Gi
    inputBinding:
      position: 104
      prefix: --defaultMemory
  - id: experiment
    type:
      - 'null'
      - File
    doc: The file containing a link to the experiment parameters
    inputBinding:
      position: 104
      prefix: --experiment
  - id: intermediate_results_url
    type:
      - 'null'
      - string
    doc: URL prefix to save intermediate results like DB dumps to (e.g. 
      prefix-dump-caf, prefix-dump-avg, etc.)
    inputBinding:
      position: 104
      prefix: --intermediateResultsUrl
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Use the latest version of the docker container rather than pulling one 
      matching this version of cactus
    inputBinding:
      position: 104
      prefix: --latest
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: Turn on logging at level CRITICAL and above. (default is INFO)
    inputBinding:
      position: 104
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on logging at level DEBUG and above. (default is INFO)
    inputBinding:
      position: 104
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: Turn on logging at level ERROR and above. (default is INFO)
    inputBinding:
      position: 104
      prefix: --logError
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in
    inputBinding:
      position: 104
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: Turn on logging at level INFO and above. (default is INFO)
    inputBinding:
      position: 104
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log at given level (may be either OFF (or CRITICAL), ERROR, WARN (or 
      WARNING), INFO or DEBUG). (default is INFO)
    inputBinding:
      position: 104
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Same as --logCritical
    inputBinding:
      position: 104
      prefix: --logOff
  - id: log_warning
    type:
      - 'null'
      - boolean
    doc: Turn on logging at level WARNING and above. (default is INFO)
    inputBinding:
      position: 104
      prefix: --logWarning
  - id: max_cores
    type:
      - 'null'
      - string
    doc: The maximum number of CPU cores to request from the batch system at any
      one time. Standard suffixes like K, Ki, M, Mi, G or Gi are supported. 
      Default is 8.0 Ei
    default: 8.0 Ei
    inputBinding:
      position: 104
      prefix: --maxCores
  - id: max_disk
    type:
      - 'null'
      - string
    doc: The maximum amount of disk space to request from the batch system at 
      any one time. Standard suffixes like K, Ki, M, Mi, G or Gi are supported. 
      Default is 8.0 Ei
    default: 8.0 Ei
    inputBinding:
      position: 104
      prefix: --maxDisk
  - id: max_job_duration
    type:
      - 'null'
      - int
    doc: Maximum runtime of a job (in seconds) before we kill it (this is a 
      lower bound, and the actual time before killing the job may be longer). 
      default=9223372036854775807
    default: 9223372036854775807
    inputBinding:
      position: 104
      prefix: --maxJobDuration
  - id: max_log_file_size
    type:
      - 'null'
      - int
    doc: The maximum size of a job log file to keep (in bytes), log files larger
      than this will be truncated to the last X bytes. Default is 50 kilobytes, 
      default=50120
    default: 50120
    inputBinding:
      position: 104
      prefix: --maxLogFileSize
  - id: max_memory
    type:
      - 'null'
      - string
    doc: The maximum amount of memory to request from the batch system at any 
      one time. Standard suffixes like K, Ki, M, Mi, G or Gi are supported. 
      Default is 8.0 Ei
    default: 8.0 Ei
    inputBinding:
      position: 104
      prefix: --maxMemory
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: Maximum number of non-preemptable nodes in the cluster, if using 
      auto-scaling. The default is 10.
    default: 10
    inputBinding:
      position: 104
      prefix: --maxNodes
  - id: max_preemptable_nodes
    type:
      - 'null'
      - int
    doc: Maximum number of preemptable nodes in the cluster, if using 
      auto-scaling. The default is 10.
    default: 10
    inputBinding:
      position: 104
      prefix: --maxPreemptableNodes
  - id: mesos_master
    type:
      - 'null'
      - string
    doc: The host and port of the Mesos master separated by colon. 
      default=localhost:5050
    default: localhost:5050
    inputBinding:
      position: 104
      prefix: --mesosMaster
  - id: min_nodes
    type:
      - 'null'
      - int
    doc: Minimum number of non-preemptable nodes in the cluster, if using 
      auto-scaling. The default is 0.
    default: 0
    inputBinding:
      position: 104
      prefix: --minNodes
  - id: min_preemptable_nodes
    type:
      - 'null'
      - int
    doc: Minimum number of preemptable nodes in the cluster, if using 
      auto-scaling. The default is 0.
    default: 0
    inputBinding:
      position: 104
      prefix: --minPreemptableNodes
  - id: node_options
    type:
      - 'null'
      - string
    doc: Provisioning options for the non-preemptable node type. The syntax 
      depends on the provisioner used. For the cgcloud provisioner this is a 
      space-separated list of options to cgcloud's grow-cluster command (run 
      'cgcloud grow-cluster --help' for details. The default is None.
    inputBinding:
      position: 104
      prefix: --nodeOptions
  - id: node_type
    type:
      - 'null'
      - string
    doc: Node type for non-preemptable nodes. The syntax depends on the 
      provisioner used. For the cgcloud provisioner this is the name of an EC2 
      instance type, for example 'c3.8xlarge'. The default is None.
    inputBinding:
      position: 104
      prefix: --nodeType
  - id: parasol_command
    type:
      - 'null'
      - string
    doc: The name or path of the parasol program. Will be looked up on PATH 
      unless it starts with a slashdefault=parasol
    default: parasol
    inputBinding:
      position: 104
      prefix: --parasolCommand
  - id: parasol_max_batches
    type:
      - 'null'
      - int
    doc: Maximum number of job batches the Parasol batch is allowed to create. 
      One batch is created for jobs with a a unique set of resource 
      requirements. default=10000
    default: 10000
    inputBinding:
      position: 104
      prefix: --parasolMaxBatches
  - id: preemptable_node_options
    type:
      - 'null'
      - string
    doc: Provisioning options for the preemptable node type. The syntax depends 
      on the provisioner used. For the cgcloud provisioner this is a 
      space-separated list of options to cgcloud's grow-cluster command (run 
      'cgcloud grow-cluster --help' for details. The default is None.
    inputBinding:
      position: 104
      prefix: --preemptableNodeOptions
  - id: preemptable_node_type
    type:
      - 'null'
      - string
    doc: Node type for preemptable nodes. The syntax depends on the provisioner 
      used. For the cgcloud provisioner this is the name of an EC2 instance 
      type, followed by a colon and the price in dollar to bid for a spot 
      instance, for example 'c3.8xlarge:0.42'. The default is None.
    inputBinding:
      position: 104
      prefix: --preemptableNodeType
  - id: provisioner
    type:
      - 'null'
      - string
    doc: The provisioner for cluster auto-scaling. Currently only the cgcloud 
      provisioner exists. The default is None.
    inputBinding:
      position: 104
      prefix: --provisioner
  - id: read_global_file_mutable_by_default
    type:
      - 'null'
      - boolean
    doc: Toil disallows modification of read global files by default. This flag 
      makes it makes read file mutable by default, however it also defeats the 
      purpose of shared caching via hard links to save space. Default is False
    inputBinding:
      position: 104
      prefix: --readGlobalFileMutableByDefault
  - id: real_time_logging
    type:
      - 'null'
      - boolean
    doc: Enable real-time logging from workers to masters
    inputBinding:
      position: 104
      prefix: --realTimeLogging
  - id: rescue_jobs_frequency
    type:
      - 'null'
      - int
    doc: Period of time to wait (in seconds) between checking for 
      missing/overlong jobs, that is jobs which get lost by the batch system. 
      Expert parameter. default=3600
    default: 3600
    inputBinding:
      position: 104
      prefix: --rescueJobsFrequency
  - id: restart
    type:
      - 'null'
      - boolean
    doc: If --restart is specified then will attempt to restart existing 
      workflow at the location pointed to by the --jobStore option. Will raise 
      an exception if the workflow does not exist
    inputBinding:
      position: 104
      prefix: --restart
  - id: retry_count
    type:
      - 'null'
      - int
    doc: Number of times to retry a failing job before giving up and labeling 
      job failed. default=0
    default: 0
    inputBinding:
      position: 104
      prefix: --retryCount
  - id: root
    type:
      - 'null'
      - string
    doc: Name of ancestral node (which must appear in NEWICK tree in <seqfile>) 
      to use as a root for the alignment. Any genomes not below this node in the
      tree may be used as outgroups but will never appear in the output. If no 
      root is specifed then the root of the tree is used.
    inputBinding:
      position: 104
      prefix: --root
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files getting too big.
    inputBinding:
      position: 104
      prefix: --rotatingLogging
  - id: scale
    type:
      - 'null'
      - float
    doc: A scaling factor to change the value of all submitted tasks's submitted
      cores. Used in singleMachine batch system. default=1
    default: 1.0
    inputBinding:
      position: 104
      prefix: --scale
  - id: scale_interval
    type:
      - 'null'
      - int
    doc: The interval (seconds) between assessing if the scale of the cluster 
      needs to change. default=360
    default: 360
    inputBinding:
      position: 104
      prefix: --scaleInterval
  - id: service_polling_interval
    type:
      - 'null'
      - int
    doc: Interval of time service jobs wait between polling for the existence of
      the keep-alive flag (defailt=60)
    default: 60
    inputBinding:
      position: 104
      prefix: --servicePollingInterval
  - id: set_env
    type:
      - 'null'
      - type: array
        items: string
    doc: Set an environment variable early on in the worker. If VALUE is 
      omitted, it will be looked up in the current environment. Independently of
      this option, the worker will try to emulate the leader's environment 
      before running a job. Using this option, a variable can be injected into 
      the worker process itself before it is started.
    inputBinding:
      position: 104
      prefix: --setEnv
  - id: sse_key
    type:
      - 'null'
      - File
    doc: Path to file containing 32 character key to be used for server-side 
      encryption on awsJobStore. SSE will not be used if this flag is not 
      passed.
    inputBinding:
      position: 104
      prefix: --sseKey
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Records statistics about the toil workflow to be used by 'toil stats'.
    inputBinding:
      position: 104
      prefix: --stats
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Absolute path to directory where temporary files generated during the 
      Toil run should be placed. Temp files and folders will be placed in a 
      directory toil-<workflowID> within workDir (The workflowID is generated by
      Toil and will be reported in the workflow logs. Default is determined by 
      the user-defined environmental variable TOIL_TEMPDIR, or the environment 
      variables (TMPDIR, TEMP, TMP) via mkdtemp. This directory needs to exist 
      on all machines running jobs.
    inputBinding:
      position: 104
      prefix: --workDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus:2019.03.01--py27hdbcaa40_0
stdout: cactus.out
