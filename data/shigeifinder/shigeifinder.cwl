cwlVersion: v1.2
class: CommandLineTool
baseCommand: shigeifinder
label: shigeifinder
doc: "Shigeifinder is a tool for the identification of Shigella and enteroinvasive
  Escherichia coli (EIEC). (Note: The provided text is a system error log and does
  not contain help documentation; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/LanLab/ShigEiFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigeifinder:1.3.5--pyhdfd78af_0
stdout: shigeifinder.out
