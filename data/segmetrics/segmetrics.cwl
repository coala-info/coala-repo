cwlVersion: v1.2
class: CommandLineTool
baseCommand: segmetrics
label: segmetrics
doc: "The provided text is a log of a failed container build process and does not
  contain help information or usage instructions for the tool.\n\nTool homepage: https://github.com/BMCV/segmetrics.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmetrics:1.5--pyhdfd78af_0
stdout: segmetrics.out
