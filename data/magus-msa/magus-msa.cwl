cwlVersion: v1.2
class: CommandLineTool
baseCommand: magus
label: magus-msa
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log regarding a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/vlasmirnov/MAGUS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magus-msa:0.2.0--pyhdfd78af_0
stdout: magus-msa.out
