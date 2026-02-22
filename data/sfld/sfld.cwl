cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfld
label: sfld
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sfld'. It consists of system error messages related to a Singularity/Docker
  container execution failure due to insufficient disk space.\n\nTool homepage: https://github.com/ebi-pf-team/interproscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfld:1.1--h7b50bb2_5
stdout: sfld.out
