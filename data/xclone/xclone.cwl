cwlVersion: v1.2
class: CommandLineTool
baseCommand: xclone
label: xclone
doc: "The provided text is a container build error log and does not contain the help
  documentation or usage instructions for the xclone tool.\n\nTool homepage: https://github.com/single-cell-genetics/XClone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xclone:0.4.0--pyhdfd78af_0
stdout: xclone.out
