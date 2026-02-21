cwlVersion: v1.2
class: CommandLineTool
baseCommand: genrich
label: genrich
doc: "Genrich is a peak-caller for genomic enrichment assays (e.g. ATAC-seq, ChIP-seq).
  Note: The provided input text contains system error messages and does not include
  the tool's help documentation.\n\nTool homepage: https://github.com/jsh58/Genrich"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genrich:0.6.1--h577a1d6_5
stdout: genrich.out
