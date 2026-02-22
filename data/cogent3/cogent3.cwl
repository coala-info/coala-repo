cwlVersion: v1.2
class: CommandLineTool
baseCommand: cogent3
label: cogent3
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to pull or build a container image due
  to insufficient disk space.\n\nTool homepage: https://pypi.org/project/cogent3/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogent3:2026.2.3a1--pyhdfd78af_0
stdout: cogent3.out
