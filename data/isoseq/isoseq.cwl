cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq
label: isoseq
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
stdout: isoseq.out
