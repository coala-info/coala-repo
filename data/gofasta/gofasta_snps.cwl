cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - snps
label: gofasta_snps
doc: "Find snps relative to a reference.\n\nTool homepage: https://github.com/cov-ert/gofasta"
inputs:
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Report the proportions of each change
    inputBinding:
      position: 101
      prefix: --aggregate
  - id: hard_gaps
    type:
      - 'null'
      - boolean
    doc: Don't treat alignment gaps as missing data
    inputBinding:
      position: 101
      prefix: --hard-gaps
  - id: query
    type:
      - 'null'
      - File
    doc: Alignment of sequences to find snps in, in fasta format
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: File
    doc: Reference sequence, in fasta format
    inputBinding:
      position: 101
      prefix: --reference
  - id: threshold
    type:
      - 'null'
      - float
    doc: If --aggregate, only report snps with a freq greater than or equal to 
      this value
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output to write
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
