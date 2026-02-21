cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - index
label: paladin_index
doc: "Index a reference genome or transcriptome for PALADIN alignment\n\nTool homepage:
  https://github.com/ToniWestbrook/paladin"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file (nucleotide or protein)
    inputBinding:
      position: 1
  - id: annotation_gff
    type:
      - 'null'
      - File
    doc: Annotation GFF file (required for nucleotide references)
    inputBinding:
      position: 2
  - id: index_all_frames
    type:
      - 'null'
      - boolean
    doc: Enable indexing all frames in nucleotide references
    inputBinding:
      position: 103
      prefix: -f
  - id: reference_type
    type:
      - 'null'
      - int
    doc: 'Reference type: 1: Nucleotide sequences (requires .gff), 2: Nucleotide sequences
      (coding only), 3: Protein sequences, 4: Development tests'
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
stdout: paladin_index.out
