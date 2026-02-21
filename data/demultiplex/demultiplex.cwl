cwlVersion: v1.2
class: CommandLineTool
baseCommand: demultiplex
label: demultiplex
doc: "A tool for demultiplexing (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/jfjlaros/demultiplex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplex:1.2.2--pyhdfd78af_1
stdout: demultiplex.out
