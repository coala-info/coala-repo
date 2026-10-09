cwlVersion: v1.2
class: CommandLineTool
baseCommand: jali
label: jali
doc: "Performs sequence alignment\n\nTool homepage: http://bibiserv.cebitec.uni-bielefeld.de/jali"
inputs:
  - id: sequence_fasta
    type: File
    doc: Input FASTA sequence file
    inputBinding:
      position: 201
  - id: alignment_fasta
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 202
  - id: format_id
    type:
      - 'null'
      - int
    doc: 0:ASCII (default) 1:HTML 2:double-spaced HTML
    inputBinding:
      position: 101
      prefix: -f
  - id: gap_extension_cost
    type:
      - 'null'
      - float
    doc: gap extension cost
    inputBinding:
      position: 101
      prefix: -e
  - id: gap_initiation_cost
    type:
      - 'null'
      - float
    doc: gap initiation cost
    inputBinding:
      position: 101
      prefix: -i
  - id: jump_cost
    type:
      - 'null'
      - float
    doc: jump cost
    inputBinding:
      position: 101
      prefix: -j
  - id: print_alignment
    type:
      - 'null'
      - boolean
    doc: print alignment
    inputBinding:
      position: 101
      prefix: -p
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
stdout: jali.out
