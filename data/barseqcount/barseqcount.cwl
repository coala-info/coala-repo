cwlVersion: v1.2
class: CommandLineTool
baseCommand: barseqcount
label: barseqcount
doc: "A tool for counting barcodes in sequencing data (Note: The provided text contains
  container build errors rather than help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/damienmarsic/barseqcount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
stdout: barseqcount.out
