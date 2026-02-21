cwlVersion: v1.2
class: CommandLineTool
baseCommand: cov-lineages
label: cov-lineages
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/cov-lineages/lineages"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cov-lineages:2020.05.19.2--pyh3252c3a_0
stdout: cov-lineages.out
