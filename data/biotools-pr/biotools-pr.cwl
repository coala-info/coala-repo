cwlVersion: v1.2
class: CommandLineTool
baseCommand: biotools-pr
label: biotools-pr
doc: "The provided text does not contain help information or a description of the
  tool; it consists of system error messages related to a failed container image pull
  due to insufficient disk space.\n\nTool homepage: https://github.com/AdeJurca/BiotoolsProject"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biotools-pr:latest
stdout: biotools-pr.out
