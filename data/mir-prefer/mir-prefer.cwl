cwlVersion: v1.2
class: CommandLineTool
baseCommand: mir-prefer
label: mir-prefer
doc: "mir-prefer: A tool for miRNA prediction (Note: The provided text contains only
  system error messages and no help documentation to parse arguments from).\n\nTool
  homepage: https://github.com/hangelwen/miR-PREFeR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mir-prefer:0.24--py27_2
stdout: mir-prefer.out
