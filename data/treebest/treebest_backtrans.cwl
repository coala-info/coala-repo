cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - backtrans
label: treebest_backtrans
doc: "Back-translate an amino acid alignment to a nucleotide alignment using nucleotide
  sequences.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: aa_aln
    type: File
    doc: Amino acid alignment file
    inputBinding:
      position: 1
  - id: nt_seq
    type: File
    doc: Nucleotide sequence file
    inputBinding:
      position: 2
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold value
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_backtrans.out
