cwlVersion: v1.2
class: CommandLineTool
baseCommand: jsearch
label: jsearch
doc: "Compares all proteins of a protein database to a multiple alignment of a protein family with jumping alignments, and outputs the database sorted by alignment score.\n\nTool homepage: http://bibiserv.cebitec.uni-bielefeld.de/jali"
inputs:
  - id: sequence_db_fasta
    type: File
    doc: Protein sequence database in FASTA format
    inputBinding:
      position: 201
  - id: alignment_fasta
    type: File
    doc: Multiple alignment of the protein family in FASTA format
    inputBinding:
      position: 202
  - id: gap_extension_cost
    type:
      - 'null'
      - float
    doc: gap extension cost, must be smaller or equal to zero (default -6)
    inputBinding:
      position: 101
      prefix: -e
  - id: gap_initiation_cost
    type:
      - 'null'
      - float
    doc: gap initiation cost, must be smaller or equal to zero (default -24)
    inputBinding:
      position: 101
      prefix: -i
  - id: jump_cost
    type:
      - 'null'
      - float
    doc: jump cost, must be smaller or equal to zero (default -22)
    inputBinding:
      position: 101
      prefix: -j
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: run in verbose mode
    inputBinding:
      position: 101
      prefix: -o
  - id: weights_filename
    type:
      - 'null'
      - File
    doc: amino acid similarity matrix (the default file vt160 is not installed in the image, so give one, for example vt160 or blosum62 from the JAli source)
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jali:1.3--0
stdout: jsearch.out
