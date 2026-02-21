cwlVersion: v1.2
class: CommandLineTool
baseCommand: campyagainst
label: campyagainst
doc: "The provided text does not contain help information for the tool 'campyagainst'.
  It is an error log indicating a failure to build a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/LanLab/campyagainst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/campyagainst:0.1.0--pyhdfd78af_0
stdout: campyagainst.out
