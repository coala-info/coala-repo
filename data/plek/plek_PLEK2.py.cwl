cwlVersion: v1.2
class: CommandLineTool
baseCommand: plek_PLEK2.py
label: plek_PLEK2.py
doc: "PLEK (Predictor of Long non-coding RNAs and messenger RNAs based on K-mer scheme)
  is a tool for identifying lncRNAs from sequence data. Note: The provided text is
  a system error log and does not contain usage information.\n\nTool homepage: https://sourceforge.net/projects/plek"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
stdout: plek_PLEK2.py.out
