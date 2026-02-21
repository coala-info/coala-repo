cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgranges
label: cgranges_bedcov-cr
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/lh3/cgranges"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgranges:0.1.1--py39hbcbf7aa_3
stdout: cgranges_bedcov-cr.out
