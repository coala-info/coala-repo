cwlVersion: v1.2
class: CommandLineTool
baseCommand: tpmcalculator
label: tpmcalculator
doc: "TPMCalculator is a tool to calculate TPM (Transcripts Per Million) values for
  genes, exons, and introns from RNA-Seq alignments.\n\nTool homepage: https://github.com/ncbi/TPMCalculator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tpmcalculator:0.0.6--h2bd4fab_0
stdout: tpmcalculator.out
