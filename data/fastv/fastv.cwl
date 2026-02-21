cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastv
label: fastv
doc: "fastv is an ultra-fast tool to identify and characterize sequences of viruses
  from sequencing data. (Note: The provided help text appears to be a container runtime
  error log and does not contain usage information or argument definitions.)\n\nTool
  homepage: https://github.com/OpenGene/fastv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastv:0.10.0--h077b44d_1
stdout: fastv.out
