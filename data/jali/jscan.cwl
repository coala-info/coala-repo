cwlVersion: v1.2
class: CommandLineTool
baseCommand: jscan
label: jscan
doc: "Compares a protein sequence to a database of multiple alignments (PRODOM format) with jumping alignments, and outputs the cluster names with their scores.\n\nTool homepage: http://bibiserv.cebitec.uni-bielefeld.de/jali"
inputs:
  - id: sequence_fasta
    type: File
    doc: Input protein sequence in FASTA format
    inputBinding:
      position: 201
  - id: alignment_db_prodom
    type: File
    doc: Database of multiple alignments in PRODOM format
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
  - id: lines_of_output
    type:
      - 'null'
      - int
    doc: print best l scores
    inputBinding:
      position: 101
      prefix: -l
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
stdout: jscan.out
