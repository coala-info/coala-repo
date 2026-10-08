cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - run
label: funnel_run
doc: "Run a task.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: cmd
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: container
    type:
      - 'null'
      - string
    doc: Containter the command runs in.
    inputBinding:
      position: 102
      prefix: --container
  - id: content
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --content
    doc: Include input file content from a file e.g. varname=/path/to/in.txt
    inputBinding:
      position: 102
  - id: cpu
    type:
      - 'null'
      - string
    doc: Number of CPUs to request.
    inputBinding:
      position: 102
      prefix: --cpu
  - id: description
    type:
      - 'null'
      - string
    doc: Task description.
    inputBinding:
      position: 102
      prefix: --description
  - id: disk
    type:
      - 'null'
      - string
    doc: Amount of disk space to request, in GB.
    inputBinding:
      position: 102
      prefix: --disk
  - id: env
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --env
    doc: Environment variables, e.g. envvar=foo
    inputBinding:
      position: 102
  - id: exec
    type:
      - 'null'
      - string
    doc: Command to be run. This command will not be evaulated by 'sh'.
    inputBinding:
      position: 102
      prefix: --exec
  - id: in_dir
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --in-dir
    doc: Input directory e.g. varname=/path/to/dir
    inputBinding:
      position: 102
  - id: in_file
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --in
    doc: Input file e.g. varname=/path/to/input.txt
    inputBinding:
      position: 102
  - id: name
    type:
      - 'null'
      - string
    doc: Task name.
    inputBinding:
      position: 102
      prefix: --name
  - id: preemptible
    type:
      - 'null'
      - boolean
    doc: Allow task to be scheduled on preemptible workers.
    inputBinding:
      position: 102
      prefix: --preemptible
  - id: print
    type:
      - 'null'
      - boolean
    doc: Print the task without running it.
    inputBinding:
      position: 102
      prefix: --print
  - id: ram
    type:
      - 'null'
      - string
    doc: Amount of RAM to request, in GB.
    inputBinding:
      position: 102
      prefix: --ram
  - id: scatter
    type:
      - 'null'
      - boolean
    doc: Scatter multiple tasks, one per row of the given file.
    inputBinding:
      position: 102
      prefix: --scatter
  - id: server
    type:
      - 'null'
      - string
    doc: Address of Funnel server.
    inputBinding:
      position: 102
      prefix: --server
  - id: sh
    type:
      - 'null'
      - string
    doc: "Command to be run. This command will be run with the shell: 'sh -c \"<sh>\"\
      '. This is the default execution mode for commands passed as args."
    inputBinding:
      position: 102
      prefix: --sh
  - id: stdin_file
    type:
      - 'null'
      - string
    doc: File to write to stdin to the command.
    inputBinding:
      position: 102
      prefix: --stdin
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tag
    doc: Arbitrary key-value tags, e.g. tagname=tagvalue
    inputBinding:
      position: 102
  - id: vol
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --vol
    doc: Define a volume on the container.
    inputBinding:
      position: 102
  - id: wait
    type:
      - 'null'
      - boolean
    doc: Wait for the task to finish before exiting.
    inputBinding:
      position: 102
      prefix: --wait
  - id: wait_for
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --wait-for
    doc: Wait for the given task IDs before running the task.
    inputBinding:
      position: 102
  - id: workdir
    type:
      - 'null'
      - string
    doc: Containter working directory.
    inputBinding:
      position: 102
      prefix: --workdir
  - id: zone
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --zone
    doc: Require task be scheduled in certain zones.
    inputBinding:
      position: 102
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: Output file e.g. varname=/path/to/output.txt
    inputBinding:
      position: 104
      prefix: --out
  - id: stderr_file_path
    type:
      - 'null'
      - string
    doc: File to write to stderr of the command.
    inputBinding:
      position: 105
      prefix: --stderr
  - id: stdout_file_path
    type:
      - 'null'
      - string
    doc: File to write to stdout of the command.
    inputBinding:
      position: 106
      prefix: --stdout
  - id: out_dir_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 107
      prefix: --out-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the task JSON with --print, otherwise the task ID)
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file e.g. varname=/path/to/output.txt
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory e.g. varname=/path/to/dir
    outputBinding:
      glob: $(inputs.out_dir_path)
  - id: stdout_file
    type:
      - 'null'
      - File
    doc: File to write to stdout of the command.
    outputBinding:
      glob: $(inputs.stdout_file_path)
  - id: stderr_file
    type:
      - 'null'
      - File
    doc: File to write to stderr of the command.
    outputBinding:
      glob: $(inputs.stderr_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_run.out
