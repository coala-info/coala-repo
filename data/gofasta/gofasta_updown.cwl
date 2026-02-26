cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - updown
label: gofasta_updown
doc: "Get pseudo-tree-aware catchments for query sequences from alignments\n\nTool
  homepage: https://github.com/cov-ert/gofasta"
inputs:
  - id: reference
    type: File
    doc: Reference sequence, in fasta format, which is treated as the root of 
      the imaginary tree
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_updown.out
