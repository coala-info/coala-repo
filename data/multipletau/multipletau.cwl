cwlVersion: v1.2
class: CommandLineTool
baseCommand: multipletau
label: multipletau
doc: "A Python library for multiple-tau autocorrelation. (Note: The provided help
  text contains only system error messages regarding a container build failure and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/FCS-analysis/multipletau"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/multipletau:v0.3.3ds-1-deb-py3_cv1
stdout: multipletau.out
