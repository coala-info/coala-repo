cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrix2gfa.py
label: mtglink_matrix2gfa.py
doc: "Convert a file containing the matrix (links between the ends of the scaffolds/contigs) to a GFA file.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: fasta
    type: File
    doc: "FASTA file containing the sequences of the scaffolds (reference genome)"
    inputBinding:
      prefix: "-fa"
  - id: matrix
    type: File
    doc: "File containing the number of common barcodes between all possible pairs of scaffolds' extremities (matrix)"
    inputBinding:
      prefix: "-matrix"
  - id: threshold
    type: int
    doc: "Minimal number of links two scaffolds must share to try to fill the gap between them"
    inputBinding:
      prefix: "-threshold"
  - id: out_gfa
    type: string
    doc: "Name of the output GFA file"
    inputBinding:
      prefix: "-out"
outputs:
  - id: gfa_out
    type: File
    doc: Output GFA file
    outputBinding:
      glob: $(inputs.out_gfa)
  - id: flanking_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Scaffold FASTA files referenced by the GFA
    outputBinding:
      glob: '*.fasta'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
