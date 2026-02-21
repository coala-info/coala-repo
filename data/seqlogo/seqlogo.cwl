cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqlogo
label: seqlogo
doc: "The provided text does not contain help information for the tool 'seqlogo'.
  It contains system error logs indicating a failure to build or run a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/betteridiot/seqlogo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqlogo:5.29.11--pyhdfd78af_0
stdout: seqlogo.out
