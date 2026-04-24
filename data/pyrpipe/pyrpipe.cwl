cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrpipe
label: pyrpipe
doc: "A lightweight python package for RNA-Seq workflows\n\nTool homepage: https://github.com/urmi-21/pyrpipe"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Only print pyrpipe's commands and not execute anything through 
      pyrpipe_engine module
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force execution of commands if their target files already exist
    inputBinding:
      position: 101
      prefix: --force
  - id: in
    type: File
    doc: The input python script
    inputBinding:
      position: 101
      prefix: --in
  - id: logs_dir
    type:
      - 'null'
      - Directory
    doc: Directory for saving log files
    inputBinding:
      position: 101
      prefix: --logs-dir
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Max memory to use (in GB)
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: multiqc
    type:
      - 'null'
      - boolean
    doc: Autorun MultiQC after execution
    inputBinding:
      position: 101
      prefix: --multiqc
  - id: no_logs
    type:
      - 'null'
      - boolean
    doc: Disable pyrpipe logs
    inputBinding:
      position: 101
      prefix: --no-logs
  - id: param_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing parameter yaml files
    inputBinding:
      position: 101
      prefix: --param-dir
  - id: safe_mode
    type:
      - 'null'
      - boolean
    doc: Disable file deletions through pyrpipe_engine module
    inputBinding:
      position: 101
      prefix: --safe-mode
  - id: threads
    type:
      - 'null'
      - int
    doc: Num processes/threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print pyrpipe_engine's stdout and stderr
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrpipe:0.0.5--py_0
stdout: pyrpipe.out
