cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairix
label: pairix
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a failed Singularity/Docker
  container execution due to insufficient disk space.\n\nTool homepage: https://github.com/4dn-dcic/pairix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
stdout: pairix.out
