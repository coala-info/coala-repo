cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromshell
label: cromshell
doc: "Cromshell is a command-line tool for submitting and managing workflows on a
  Cromwell server. Note: The provided input text contains system error logs rather
  than help documentation, so specific arguments could not be extracted from the source.\n
  \nTool homepage: https://github.com/broadinstitute/cromshell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell.out
