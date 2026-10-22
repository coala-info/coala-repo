cwlVersion: v1.2
class: CommandLineTool
baseCommand: keep-header
label: tsv-utils_keep-header
doc: "Execute a command against one or more files in a header aware fashion. The first header is output unchanged and the remaining lines are sent to the command on standard input.\n\nTool homepage: https://github.com/eBay/tsv-utils"
arguments:
  - position: 2
    valueFrom: "--"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input files. The first line of each file is the header. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: command
    type:
      type: array
      items: string
    doc: "Command and arguments to run on the data lines (after the -- separator)."
    inputBinding:
      position: 3
outputs:
  - id: output
    type: stdout
    doc: "Header followed by the command output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: keep-header_output.txt
