cwlVersion: v1.2
class: CommandLineTool
baseCommand: bttoxin_digger
label: bttoxin_digger
doc: "A tool for scanning and identifying Bt toxins. (Note: The provided input text
  contains system error messages regarding disk space and container image conversion
  rather than the tool's help documentation.)\n\nTool homepage: https://github.com/liaochenlanruo/BtToxin_Digger/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bttoxin_scanner:2.0.1--0
stdout: bttoxin_digger.out
