cwlVersion: v1.2
class: CommandLineTool
baseCommand: kamino
label: kamino
doc: "Build phylogenomic datasets in seconds.\n\nTool homepage: https://github.com/rderelle/kamino"
inputs:
  - id: constant
    type:
      - 'null'
      - int
    doc: Number of constant positions to keep from the in-bubble k-mer
    default: 3
    inputBinding:
      position: 101
      prefix: --constant
  - id: depth
    type:
      - 'null'
      - int
    doc: Maximum traversal depth from each start node
    default: 6
    inputBinding:
      position: 101
      prefix: --depth
  - id: input_directory
    type: Directory
    doc: Input directory with FASTA proteomes (plain or .gz)
    inputBinding:
      position: 101
      prefix: --input-directory
  - id: input_file
    type: File
    doc: Tab-delimited file mapping species name to proteome path
    inputBinding:
      position: 101
      prefix: --input-file
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer length
    default: 14
    inputBinding:
      position: 101
      prefix: --k
  - id: length_middle
    type:
      - 'null'
      - string
    doc: Maximum number of middle positions per variant group
    inputBinding:
      position: 101
      prefix: --length-middle
  - id: mask
    type:
      - 'null'
      - int
    doc: Mask middle segments with long mismatch runs
    default: 5
    inputBinding:
      position: 101
      prefix: --mask
  - id: min_freq
    type:
      - 'null'
      - float
    doc: Minimal fraction of samples with an amino-acid per position
    default: 0.85
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: nj
    type:
      - 'null'
      - boolean
    doc: Generate a NJ tree from kamino alignment
    default: false
    inputBinding:
      position: 101
      prefix: --nj
  - id: output
    type:
      - 'null'
      - string
    doc: Output prefix
    default: kamino
    inputBinding:
      position: 101
      prefix: --output
  - id: recode
    type:
      - 'null'
      - string
    doc: Recoding scheme
    default: sr6
    inputBinding:
      position: 101
      prefix: --recode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kamino:0.7.0--h4349ce8_0
stdout: kamino.out
