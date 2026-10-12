cwlVersion: v1.2
class: CommandLineTool
baseCommand: parallel
label: parallel
doc: "GNU parallel: run jobs in parallel, from arguments on the command line (:::,
  ::::) or from standard input, or split standard input into blocks with --pipe.\n\
  \nTool homepage: https://www.gnu.org/software/parallel/"
inputs:
  - id: jobs
    type:
      - 'null'
      - string
    doc: Run n jobs in parallel (a number, a percentage such as 50%, or +N / -N)
    inputBinding:
      position: 1
      prefix: -j
  - id: keep_order
    type:
      - 'null'
      - boolean
    doc: Keep same order
    inputBinding:
      position: 2
      prefix: -k
  - id: multiple_args_with_context_replace
    type:
      - 'null'
      - boolean
    doc: Multiple arguments with context replace
    inputBinding:
      position: 3
      prefix: -X
  - id: colsep
    type:
      - 'null'
      - string
    doc: Split input on regexp for positional replacements
    inputBinding:
      position: 4
      prefix: --colsep
  - id: plus
    type:
      - 'null'
      - boolean
    doc: Add more replacement strings
    inputBinding:
      position: 5
      prefix: --plus
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Split stdin (standard input) to multiple jobs.
    inputBinding:
      position: 6
      prefix: --pipe
  - id: recstart
    type:
      - 'null'
      - string
    doc: Record start separator for --pipe.
    inputBinding:
      position: 7
      prefix: --recstart
  - id: recend
    type:
      - 'null'
      - string
    doc: Record end separator for --pipe.
    inputBinding:
      position: 8
      prefix: --recend
  - id: run_onall
    type:
      - 'null'
      - boolean
    doc: Run the given command with argument on all sshlogins
    inputBinding:
      position: 9
      prefix: --onall
  - id: run_nonall
    type:
      - 'null'
      - boolean
    doc: Run the given command with no arguments on all sshlogins
    inputBinding:
      position: 10
      prefix: --nonall
  - id: sshlogin
    type:
      - 'null'
      - string
    doc: 'Example: foo@server.example.com'
    inputBinding:
      position: 11
      prefix: -S
  - id: use_sshloginfile
    type:
      - 'null'
      - string
    doc: Use ~/.parallel/sshloginfile as the list of sshlogins
    inputBinding:
      position: 12
      prefix: --slf
  - id: transfer
    type:
      - 'null'
      - boolean
    doc: Transfer files to the sshlogin before the job runs
    inputBinding:
      position: 13
      prefix: --transfer
  - id: return_files
    type:
      - 'null'
      - string
    doc: 'Transfer files back from the sshlogin after the job (a replacement string such as {}.bar)'
    inputBinding:
      position: 14
      prefix: --return
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Remove transferred files from the sshlogin after the job
    inputBinding:
      position: 15
      prefix: --cleanup
  - id: transfer_return_cleanup
    type:
      - 'null'
      - string
    doc: 'Shorthand for --transfer --return {}.bar --cleanup'
    inputBinding:
      position: 16
      prefix: --trc
  - id: command
    type:
      - 'null'
      - string
    doc: 'Command to execute (may contain replacement strings such as {}, {.}, {/} and {#})'
    inputBinding:
      position: 20
  - id: command_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Fixed arguments for the command
    inputBinding:
      position: 21
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments, one job per value (:::)
    inputBinding:
      position: 22
      prefix: ':::'
  - id: arguments_from_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Arguments read from one or more files, one job per line (::::)
    inputBinding:
      position: 23
      prefix: '::::'
  - id: list_of_arguments
    type:
      - 'null'
      - File
    doc: List of arguments (or the data to split with --pipe), read from standard input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
stdin: '$(inputs.list_of_arguments ? inputs.list_of_arguments.path : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel:20180322-0
stdout: parallel.out
requirements:
  - class: InlineJavascriptRequirement
