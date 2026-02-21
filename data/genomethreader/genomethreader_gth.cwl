cwlVersion: v1.2
class: CommandLineTool
baseCommand: gth
label: genomethreader_gth
doc: "GenomeThreader is a software tool to compute gene structure predictions. Note:
  The provided help text contains only container runtime error messages and does not
  list specific command-line arguments.\n\nTool homepage: http://genomethreader.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomethreader:1.7.1--h503566f_7
stdout: genomethreader_gth.out
