cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-sam-validator
label: rsem_rsem-sam-validator
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime failure.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem_rsem-sam-validator.out
