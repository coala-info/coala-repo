cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hpcrunner.pl
  - single_node
label: perl-hpc-runner-command_single_node
doc: "Take the parsed files from hpcrunner.pl submit_jobs and executes the code on a single node or workstation\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TZ
        envValue: UTC
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
inputs:
  - id: plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: "Load application plugins (comma separated)"
    inputBinding:
      position: 101
      prefix: --plugins
      itemSeparator: ','
  - id: plugins_opts
    type:
      - 'null'
      - string
    doc: "Options for application plugins [Key-Value]"
    inputBinding:
      position: 101
      prefix: --plugins_opts
  - id: config_base
    type:
      - 'null'
      - string
    doc: "Basename of config files [Default:\".hpcrunner\"]"
    inputBinding:
      position: 101
      prefix: --config_base
  - id: search_path
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --search_path
    doc: "Enable a search path for configs; default is the home dir and your cwd"
    inputBinding:
      position: 101
  - id: no_configs
    type:
      - 'null'
      - boolean
    doc: "Tell HPC::Runner not to load any configs"
    inputBinding:
      position: 101
      prefix: --no_configs
  - id: config
    type:
      - 'null'
      - File
    doc: "Override the search paths and supply your own config"
    inputBinding:
      position: 101
      prefix: --config
  - id: search
    type:
      - 'null'
      - boolean
    doc: "Search for config files in ~/.config.(ext) and in your current working directory"
    inputBinding:
      position: 101
      prefix: --search
  - id: project
    type:
      - 'null'
      - string
    doc: "Give your jobnames an additional project name"
    inputBinding:
      position: 101
      prefix: --project
  - id: no_log_json
    type:
      - 'null'
      - boolean
    doc: "Opt out of writing the tar archive of JSON stats"
    inputBinding:
      position: 101
      prefix: --no_log_json
  - id: data_dir
    type:
      - 'null'
      - string
    doc: "Data directory for hpcrunner"
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the commands of the infile; staged into the working directory"
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Directory to write out files"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: basedir
    type:
      - 'null'
      - string
    doc: "Base directory to write out files"
    inputBinding:
      position: 101
      prefix: --basedir
  - id: poll_time
    type:
      - 'null'
      - int
    doc: "Time in seconds to poll the process for memory profiling [Default:5]"
    inputBinding:
      position: 101
      prefix: --poll_time
  - id: procs
    type:
      - 'null'
      - int
    doc: "Total number of concurrently running jobs allowed at any time [Default:1]"
    inputBinding:
      position: 101
      prefix: --procs
  - id: memory_diff
    type:
      - 'null'
      - double
    doc: "Difference from last memory profile in order to record [Default:0.1]"
    inputBinding:
      position: 101
      prefix: --memory_diff
  - id: infile
    type: File
    doc: "File of commands separated by newline; the command 'wait' indicates all previous commands should finish before starting the next one"
    inputBinding:
      position: 101
      prefix: --infile
  - id: metastr
    type:
      - 'null'
      - string
    doc: "Meta str passed from HPC::Runner::Command::Scheduler"
    inputBinding:
      position: 101
      prefix: --metastr
  - id: logdir
    type:
      - 'null'
      - string
    doc: "Directory where logfiles are written"
    inputBinding:
      position: 101
      prefix: --logdir
  - id: logname
    type:
      - 'null'
      - string
    doc: "Name of the log directory [Default:000_hpcrunner_logs]"
    inputBinding:
      position: 101
      prefix: --logname
  - id: show_processid
    type:
      - 'null'
      - boolean
    doc: "Show the process ID per logging message"
    inputBinding:
      position: 101
      prefix: --show_processid
  - id: process_table
    type:
      - 'null'
      - string
    doc: "Process table"
    inputBinding:
      position: 101
      prefix: --process_table
  - id: tags
    type:
      - 'null'
      - type: array
        items: string
    doc: "Annotate with tags (comma separated)"
    inputBinding:
      position: 101
      prefix: --tags
      itemSeparator: ','
  - id: autocommit
    type:
      - 'null'
      - boolean
    doc: "Always commit files"
    inputBinding:
      position: 101
      prefix: --autocommit
  - id: message
    type:
      - 'null'
      - string
    doc: "Message to use for git commit [Default:hpcrunner commit]"
    inputBinding:
      position: 101
      prefix: --message
  - id: version
    type:
      - 'null'
      - string
    doc: "Submission version; each version has a corresponding git tag"
    inputBinding:
      position: 101
      prefix: --version
  - id: job_plugins_opts
    type:
      - 'null'
      - string
    doc: "Options for job_plugins [Key-Value]"
    inputBinding:
      position: 101
      prefix: --job_plugins_opts
  - id: commands
    type:
      - 'null'
      - int
    doc: "Number of commands per job [Default:1]"
    inputBinding:
      position: 101
      prefix: --commands
  - id: jobname
    type:
      - 'null'
      - string
    doc: "Specify a job name, each job will be appended with its batch order"
    inputBinding:
      position: 101
      prefix: --jobname
  - id: single_node
    type:
      - 'null'
      - boolean
    doc: "Run a job from a single node or workstation"
    inputBinding:
      position: 101
      prefix: --single_node
  - id: job_plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: "Load job execution plugins (comma separated)"
    inputBinding:
      position: 101
      prefix: --job_plugins
      itemSeparator: ','
  - id: batch_index_start
    type:
      - 'null'
      - int
    doc: "Counter to tell execute_array where to start reading in the infile; omit to run in single node"
    inputBinding:
      position: 101
      prefix: --batch_index_start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: hpc_runner_dir
    type:
      - 'null'
      - Directory
    doc: Default log directory with the logs and JSON stats of every task
    outputBinding:
      glob: hpc-runner
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: Directory written with the outdir option
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command_single_node.out
