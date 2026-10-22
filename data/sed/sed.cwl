cwlVersion: v1.2
class: CommandLineTool
baseCommand: sed
label: sed
doc: "GNU sed, a stream editor to filter and transform text. The in-place option -i\
  \ is not wrapped because staged inputs are read-only; the result goes to standard\
  \ output.\n\nTool homepage: https://www.gnu.org/software/sed/"
inputs:
  - id: quiet
    type: ['null', boolean]
    doc: Suppress automatic printing of pattern space
    inputBinding:
      position: 1
      prefix: -n
  - id: debug
    type: ['null', boolean]
    doc: Annotate program execution
    inputBinding:
      position: 1
      prefix: --debug
  - id: expression
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -e
    doc: Add the script to the commands to be executed
    inputBinding:
      position: 2
  - id: script_file
    type: ['null', File]
    doc: Add the contents of script-file to the commands to be executed
    inputBinding:
      position: 2
      prefix: -f
  - id: follow_symlinks
    type: ['null', boolean]
    doc: Follow symlinks when processing in place
    inputBinding:
      position: 1
      prefix: --follow-symlinks
  - id: line_length
    type: ['null', int]
    doc: Specify the desired line-wrap length for the `l' command
    inputBinding:
      position: 1
      prefix: -l
  - id: posix
    type: ['null', boolean]
    doc: Disable all GNU extensions
    inputBinding:
      position: 1
      prefix: --posix
  - id: regexp_extended
    type: ['null', boolean]
    doc: Use extended regular expressions in the script
    inputBinding:
      position: 1
      prefix: -E
  - id: separate
    type: ['null', boolean]
    doc: Consider files as separate rather than as a single, continuous long stream
    inputBinding:
      position: 1
      prefix: -s
  - id: sandbox
    type: ['null', boolean]
    doc: Operate in sandbox mode (disable e/r/w commands)
    inputBinding:
      position: 1
      prefix: --sandbox
  - id: unbuffered
    type: ['null', boolean]
    doc: Load minimal amounts of data from the input files and flush the output buffers more often
    inputBinding:
      position: 1
      prefix: -u
  - id: null_data
    type: ['null', boolean]
    doc: Separate lines by NUL characters
    inputBinding:
      position: 1
      prefix: -z
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files
    inputBinding:
      position: 10
outputs:
  - id: output
    type: stdout
    doc: Edited text
hints:
  - class: DockerRequirement
    dockerPull: debian:bookworm-20251229-slim
stdout: sed.out
