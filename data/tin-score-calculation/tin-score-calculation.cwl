cwlVersion: v1.2
class: CommandLineTool
baseCommand: tin-score-calculation
label: tin-score-calculation
doc: "A tool for calculating TIN (Transcript Integrity Number) scores to evaluate
  RNA-seq data quality.\n\nTool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tin-score-calculation:0.6.3--pyh5e36f6f_0
stdout: tin-score-calculation.out
