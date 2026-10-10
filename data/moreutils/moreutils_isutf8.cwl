cwlVersion: v1.2
class: CommandLineTool
baseCommand: isutf8
label: moreutils_isutf8
doc: "Check whether input files are valid UTF-8. Prints the position of the
  first invalid byte of each bad file and exits with status 1 when a file is not
  valid UTF-8.\n\nTool homepage: https://github.com/madx/moreutils"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Files to check.
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print anything, only set the exit status.
    inputBinding:
      position: 1
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
successCodes: [0, 1]
stdout: moreutils_isutf8.out
