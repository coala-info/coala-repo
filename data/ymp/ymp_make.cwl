cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - make
label: ymp_make
doc: "Build target(s) locally\n\nTool homepage: https://ymp.readthedocs.io"
inputs:
  - id: target_files
    type:
      type: array
      items: string
    doc: Target files to build
    inputBinding:
      position: 1
  - id: cores
    type:
      - 'null'
      - int
    doc: The number of parallel threads used for scheduling jobs
    inputBinding:
      position: 102
      prefix: --cores
  - id: dag
    type:
      - 'null'
      - boolean
    doc: Print the Snakemake execution DAG and exit
    inputBinding:
      position: 102
      prefix: --dag
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set the Snakemake debug flag
    inputBinding:
      position: 102
      prefix: --debug
  - id: debug_dag
    type:
      - 'null'
      - boolean
    doc: Show candidates and selections made while the rule execution graph is 
      being built
    inputBinding:
      position: 102
      prefix: --debug-dag
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
  - id: keepgoing
    type:
      - 'null'
      - boolean
    doc: Don't stop after failed job
    inputBinding:
      position: 102
      prefix: --keepgoing
  - id: log_file
    type:
      - 'null'
      - string
    doc: Specify a log file
    inputBinding:
      position: 102
      prefix: --log-file
  - id: no_lock
    type:
      - 'null'
      - boolean
    doc: Don't use locking to prevent clobbering of files by parallel instances 
      of YMP running
    inputBinding:
      position: 102
      prefix: --no-lock
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
  - id: rulegraph
    type:
      - 'null'
      - boolean
    doc: Print the Snakemake rule graph and exit
    inputBinding:
      position: 102
      prefix: --rulegraph
  - id: scheduler
    type:
      - 'null'
      - string
    doc: ILP or greedy
    inputBinding:
      position: 102
      prefix: --scheduler
  - id: shadow_prefix
    type:
      - 'null'
      - string
    doc: Directory to place data for shadowed rules
    inputBinding:
      position: 102
      prefix: --shadow-prefix
  - id: touch
    type:
      - 'null'
      - boolean
    doc: Only touch files, faking update
    inputBinding:
      position: 102
      prefix: --touch
  - id: use_lock
    type:
      - 'null'
      - boolean
    doc: Use locking to prevent clobbering of files by parallel instances of YMP
      running
    inputBinding:
      position: 102
      prefix: --lock
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase log verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_make.out
