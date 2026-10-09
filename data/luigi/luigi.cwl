cwlVersion: v1.2
class: CommandLineTool
baseCommand: luigi
label: luigi
doc: "Run a Luigi workflow task from a Python module with the luigi command line runner.\n\nThe task classes live in a Python module that you supply in module_files; the module and any data files named in the task parameters are staged in the working directory, which is on the Python path. Task outputs are written to the working directory and collected with output_glob.\n\nTool homepage: https://github.com/spotify/luigi"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.module_files ? inputs.module_files : [])"
      - entry: "$(inputs.data_files ? inputs.data_files : [])"
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: $(runtime.outdir)
inputs:
  - id: task
    type: string
    doc: Task family (class name) to run
    inputBinding:
      position: 10
  - id: task_params
    type:
      - 'null'
      - type: array
        items: string
    doc: Task-specific options such as --fasta genome.fasta
    inputBinding:
      position: 11
  - id: module
    type:
      - 'null'
      - string
    doc: Used for dynamic loading of modules (name of the Python module, without .py)
    inputBinding:
      position: 1
      prefix: --module
  - id: module_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Python module files that define the tasks; staged in the working directory
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input data files used by the tasks; staged in the working directory
  - id: output_glob
    type:
      - 'null'
      - string
    doc: Glob pattern for the files the tasks write (default '*.txt')
  - id: local_scheduler
    type:
      - 'null'
      - boolean
    doc: Use an in-memory central scheduler. Useful for testing.
    inputBinding:
      position: 2
      prefix: --local-scheduler
  - id: scheduler_host
    type:
      - 'null'
      - string
    doc: Hostname of machine running remote scheduler
    inputBinding:
      position: 2
      prefix: --scheduler-host
  - id: scheduler_port
    type:
      - 'null'
      - int
    doc: Port of remote scheduler api process
    inputBinding:
      position: 2
      prefix: --scheduler-port
  - id: scheduler_url
    type:
      - 'null'
      - string
    doc: Full path to remote scheduler
    inputBinding:
      position: 2
      prefix: --scheduler-url
  - id: workers
    type:
      - 'null'
      - int
    doc: Maximum number of parallel tasks to run
    inputBinding:
      position: 2
      prefix: --workers
  - id: lock_size
    type:
      - 'null'
      - int
    doc: Maximum number of workers running the same command
    inputBinding:
      position: 2
      prefix: --lock-size
  - id: no_lock
    type:
      - 'null'
      - boolean
    doc: Ignore if similar process is already running
    inputBinding:
      position: 2
      prefix: --no-lock
  - id: lock_pid_dir
    type:
      - 'null'
      - string
    doc: Directory to store the pid file
    inputBinding:
      position: 2
      prefix: --lock-pid-dir
  - id: take_lock
    type:
      - 'null'
      - boolean
    doc: Signal other processes to stop getting work if already running
    inputBinding:
      position: 2
      prefix: --take-lock
  - id: logging_conf_file
    type:
      - 'null'
      - File
    doc: Configuration file for logging
    inputBinding:
      position: 2
      prefix: --logging-conf-file
  - id: log_level
    type:
      - 'null'
      - type: enum
        symbols: [INFO, NOTSET, DEBUG, ERROR, CRITICAL, WARNING]
    doc: Default log level to use when logging_conf_file is not set
    inputBinding:
      position: 2
      prefix: --log-level
  - id: parallel_scheduling
    type:
      - 'null'
      - boolean
    doc: Use multiprocessing to do scheduling in parallel.
    inputBinding:
      position: 2
      prefix: --parallel-scheduling
  - id: assistant
    type:
      - 'null'
      - boolean
    doc: Run any task from the scheduler.
    inputBinding:
      position: 2
      prefix: --assistant
  - id: worker_keep_alive
    type:
      - 'null'
      - boolean
    doc: Keep the worker alive while tasks are pending
    inputBinding:
      position: 2
      prefix: --worker-keep-alive
  - id: worker_timeout
    type:
      - 'null'
      - int
    doc: Worker timeout in seconds
    inputBinding:
      position: 2
      prefix: --worker-timeout
  - id: worker_task_limit
    type:
      - 'null'
      - int
    doc: Maximum number of tasks a worker may run
    inputBinding:
      position: 2
      prefix: --worker-task-limit
  - id: worker_retry_external_tasks
    type:
      - 'null'
      - boolean
    doc: If true, incomplete external tasks will be retested for completion while Luigi is running.
    inputBinding:
      position: 2
      prefix: --worker-retry-external-tasks
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: Files written by the tasks
    outputBinding:
      glob: "$(inputs.output_glob ? inputs.output_glob : '*.txt')"
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Luigi log and execution summary (written to standard error)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/luigi:phenomenal-v2.6.0_cv0.1.6
stdout: luigi.out
stderr: luigi.err
