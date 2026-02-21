cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcltk
label: xclone_xcltk
doc: "XClone toolkit (Note: The provided text is a system error log from a container
  runtime and does not contain the help documentation for the tool itself).\n\nTool
  homepage: https://github.com/single-cell-genetics/XClone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xclone:0.4.0--pyhdfd78af_0
stdout: xclone_xcltk.out
