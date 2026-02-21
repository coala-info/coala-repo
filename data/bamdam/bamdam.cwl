cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam
label: bamdam
doc: "The provided text does not contain help information for the tool 'bamdam'. It
  is a system error log indicating a failure to build or fetch a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/bdesanctis/bamdam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
stdout: bamdam.out
