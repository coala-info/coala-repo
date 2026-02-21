cwlVersion: v1.2
class: CommandLineTool
baseCommand: debwt
label: debwt
doc: "DeBWT: a parallel Burrows-Wheeler Transform construction algorithm. (Note: The
  provided text contains system error messages regarding container image conversion
  and does not include the tool's help documentation or usage instructions.)\n\nTool
  homepage: https://github.com/DixianZhu/deBWT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debwt:1.0.1--h577a1d6_8
stdout: debwt.out
