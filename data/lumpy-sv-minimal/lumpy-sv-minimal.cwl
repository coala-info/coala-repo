cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpy
label: lumpy-sv-minimal
doc: "LUMPY: a probabilistic framework for structural variant discovery. (Note: The
  provided help text contains only system error messages and no usage information;
  arguments could not be extracted from the input.)\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
stdout: lumpy-sv-minimal.out
