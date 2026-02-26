cwlVersion: v1.2
class: CommandLineTool
baseCommand: parallel
label: parallel
doc: "Run jobs in parallel\n\nTool homepage: https://github.com/PaddlePaddle/Paddle"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: list_of_arguments
    type:
      - 'null'
      - File
    doc: List of arguments from a file
    inputBinding:
      position: 2
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 3
  - id: arguments_from_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Arguments from one or more files
    inputBinding:
      position: 4
  - id: colsep
    type:
      - 'null'
      - string
    doc: Split input on regexp for positional replacements
    inputBinding:
      position: 105
      prefix: --colsep
  - id: jobs
    type:
      - 'null'
      - int
    doc: Run n jobs in parallel
    inputBinding:
      position: 105
      prefix: -j
  - id: keep_order
    type:
      - 'null'
      - boolean
    doc: Keep same order
    inputBinding:
      position: 105
      prefix: -k
  - id: multiple_args_with_context_replace
    type:
      - 'null'
      - boolean
    doc: Multiple arguments with context replace
    inputBinding:
      position: 105
      prefix: -X
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Split stdin (standard input) to multiple jobs.
    inputBinding:
      position: 105
      prefix: --pipe
  - id: recend
    type:
      - 'null'
      - string
    doc: Record end separator for --pipe.
    inputBinding:
      position: 105
      prefix: --recend
  - id: recstart
    type:
      - 'null'
      - string
    doc: Record start separator for --pipe.
    inputBinding:
      position: 105
      prefix: --recstart
  - id: run_nonall
    type:
      - 'null'
      - boolean
    doc: Run the given command with no arguments on all sshlogins
    inputBinding:
      position: 105
      prefix: --nonall
  - id: run_onall
    type:
      - 'null'
      - boolean
    doc: Run the given command with argument on all sshlogins
    inputBinding:
      position: 105
      prefix: --onall
  - id: sshlogin
    type:
      - 'null'
      - string
    doc: 'Example: foo@server.example.com'
    inputBinding:
      position: 105
      prefix: -S
  - id: transfer_return_cleanup
    type:
      - 'null'
      - string
    doc: Shorthand for --transfer --return {}.bar --cleanup
    inputBinding:
      position: 105
      prefix: --trc
  - id: use_sshloginfile
    type:
      - 'null'
      - string
    doc: Use ~/.parallel/sshloginfile as the list of sshlogins
    inputBinding:
      position: 105
      prefix: --slf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel:20180322-0
stdout: parallel.out
