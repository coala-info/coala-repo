cwlVersion: v1.2
class: CommandLineTool
baseCommand: bttoxin_scanner
label: bttoxin_scanner
doc: "A tool for scanning and identifying Bacillus thuringiensis (Bt) toxins. Note:
  The provided text contains system error messages rather than the standard help documentation,
  so no arguments could be extracted from the input.\n\nTool homepage: https://github.com/liaochenlanruo/BtToxin_scanner/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bttoxin_scanner:2.0.1--0
stdout: bttoxin_scanner.out
