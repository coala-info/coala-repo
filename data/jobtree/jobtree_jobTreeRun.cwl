cwlVersion: v1.2
class: CommandLineTool
baseCommand: jobTreeRun
label: jobtree_jobTreeRun
doc: "Options\n\nTool homepage: https://github.com/benedictpaten/jobTree"
inputs:
  - id: batch_system
    type:
      - 'null'
      - string
    doc: The type of batch system to run the job(s) with, currently can be 
      'singleMachine'/'parasol'/'acidTest'/'gridEngine'/'lsf'.
    inputBinding:
      position: 101
      prefix: --batchSystem
  - id: big_batch_system
    type:
      - 'null'
      - string
    doc: The batch system to run for jobs with larger memory/cpus requests, 
      currently can be 'singleMachine'/'parasol'/'acidTest'/'gridEngine'.
    inputBinding:
      position: 101
      prefix: --bigBatchSystem
  - id: big_cpu_threshold
    type:
      - 'null'
      - int
    doc: The cpu threshold above which to submit to the big queue.
    inputBinding:
      position: 101
      prefix: --bigCpuThreshold
  - id: big_max_cpus
    type:
      - 'null'
      - int
    doc: The maximum number of big batch system cpus to allow at one time on the
      big queue.
    inputBinding:
      position: 101
      prefix: --bigMaxCpus
  - id: big_max_memory
    type:
      - 'null'
      - int
    doc: The maximum amount of memory to request from the big batch system at 
      any one time.
    inputBinding:
      position: 101
      prefix: --bigMaxMemory
  - id: big_memory_threshold
    type:
      - 'null'
      - int
    doc: The memory threshold above which to submit to the big queue.
    inputBinding:
      position: 101
      prefix: --bigMemoryThreshold
  - id: command
    type:
      - 'null'
      - string
    doc: The command to run (which will generate subsequent jobs). This is 
      deprecated
    inputBinding:
      position: 101
      prefix: --command
  - id: default_cpu
    type:
      - 'null'
      - int
    doc: The default the number of cpus to dedicate a job.
    inputBinding:
      position: 101
      prefix: --defaultCpu
  - id: default_memory
    type:
      - 'null'
      - int
    doc: The default amount of memory to request for a job (in bytes), by 
      default is 2^31 = 2 gigabytes
    inputBinding:
      position: 101
      prefix: --defaultMemory
  - id: job_time
    type:
      - 'null'
      - int
    doc: The approximate time (in seconds) that you'd like a list of child jobs 
      to be run serially before being parallelized. This parameter allows one to
      avoid over parallelizing tiny jobs, and therefore paying significant 
      scheduling overhead, by running tiny jobs in series on a single node/core 
      of the cluster.
    inputBinding:
      position: 101
      prefix: --jobTime
  - id: job_tree
    type:
      - 'null'
      - Directory
    doc: Directory in which to place job management files and the global 
      accessed temporary file directories(this needs to be globally accessible 
      by all machines running jobs). If you pass an existing directory it will 
      check if it's a valid existing job tree, then try and restart the jobs in 
      it.
    inputBinding:
      position: 101
      prefix: --jobTree
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on logging at DEBUG level. (default is CRITICAL)
    inputBinding:
      position: 101
      prefix: --logDebug
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in
    inputBinding:
      position: 101
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: Turn on logging at INFO level. (default is CRITICAL)
    inputBinding:
      position: 101
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log at level (may be either OFF/INFO/DEBUG/CRITICAL).
    inputBinding:
      position: 101
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Turn off logging. (default is CRITICAL)
    inputBinding:
      position: 101
      prefix: --logOff
  - id: max_cpus
    type:
      - 'null'
      - int
    doc: The maximum number of cpus to request from the batch system at any one 
      time.
    inputBinding:
      position: 101
      prefix: --maxCpus
  - id: max_job_duration
    type:
      - 'null'
      - int
    doc: Maximum runtime of a job (in seconds) before we kill it (this is a 
      lower bound, and the actual time before killing the job may be longer).
    inputBinding:
      position: 101
      prefix: --maxJobDuration
  - id: max_log_file_size
    type:
      - 'null'
      - int
    doc: The maximum size of a job log file to keep (in bytes), log files larger
      than this will be truncated to the last X bytes. Default is 50 kilobytes
    inputBinding:
      position: 101
      prefix: --maxLogFileSize
  - id: max_memory
    type:
      - 'null'
      - int
    doc: The maximum amount of memory to request from the batch system at any 
      one time.
    inputBinding:
      position: 101
      prefix: --maxMemory
  - id: max_threads
    type:
      - 'null'
      - int
    doc: The maximum number of threads (technically processes at this point) to 
      use when running in single machine mode. Increasing this will allow more 
      jobs to run concurrently when running on a single machine.
    inputBinding:
      position: 101
      prefix: --maxThreads
  - id: parasol_command
    type:
      - 'null'
      - string
    doc: The command to run the parasol program
    inputBinding:
      position: 101
      prefix: --parasolCommand
  - id: rescue_jobs_frequency
    type:
      - 'null'
      - int
    doc: Period of time to wait (in seconds) between checking for 
      missing/overlong jobs, that is jobs which get lost by the batch system. 
      Expert parameter. (default is set by the batch system)
    inputBinding:
      position: 101
      prefix: --rescueJobsFrequency
  - id: retry_count
    type:
      - 'null'
      - int
    doc: Number of times to retry a failing job before giving up and labeling 
      job failed.
    inputBinding:
      position: 101
      prefix: --retryCount
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files getting too big.
    inputBinding:
      position: 101
      prefix: --rotatingLogging
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Records statistics about the job-tree to be used by jobTreeStats.
    inputBinding:
      position: 101
      prefix: --stats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jobtree:09.04.2017--py_2
stdout: jobtree_jobTreeRun.out
