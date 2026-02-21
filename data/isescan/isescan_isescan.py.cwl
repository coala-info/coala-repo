cwlVersion: v1.2
class: CommandLineTool
baseCommand: isescan.py
label: isescan_isescan.py
doc: "ISEScan is a tool for identifying Insertion Sequences (IS) in prokaryotic genomes.
  Note: The provided help text contains only container runtime error messages and
  no CLI argument information.\n\nTool homepage: https://github.com/xiezhq/ISEScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isescan:1.7.3--h7b50bb2_0
stdout: isescan_isescan.py.out
