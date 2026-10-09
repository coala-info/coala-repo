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
    inputBinding:
      position: 101
      prefix: --constant
  - id: depth
    type:
      - 'null'
      - int
    doc: Maximum traversal depth from each start node
    inputBinding:
      position: 101
      prefix: --depth
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Input directory with FASTA proteomes (plain or .gz)
    inputBinding:
      position: 101
      prefix: --input-directory
  - id: input_file
    type:
      - 'null'
      - File
    doc: Tab-delimited file mapping species name to proteome path (paths relative to this file; the file is staged in the working directory)
    inputBinding:
      position: 101
      prefix: --input-file
      valueFrom: $(self.basename)
  - id: proteomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Proteome FASTA files named in the input file, staged beside it
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer length
    inputBinding:
      position: 101
      prefix: --k
  - id: length_middle
    type:
      - 'null'
      - int
    doc: Maximum number of middle positions per variant group
    inputBinding:
      position: 101
      prefix: --length-middle
  - id: mask
    type:
      - 'null'
      - int
    doc: Mask middle segments with long mismatch runs
    inputBinding:
      position: 101
      prefix: --mask
  - id: min_freq
    type:
      - 'null'
      - float
    doc: Minimal fraction of samples with an amino-acid per position
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: nj
    type:
      - 'null'
      - boolean
    doc: Generate a NJ tree from kamino alignment
    inputBinding:
      position: 101
      prefix: --nj
  - id: output
    type: string
    default: kamino
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: recode
    type:
      - 'null'
      - string
    doc: Recoding scheme
    inputBinding:
      position: 101
      prefix: --recode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)
      - $(inputs.proteomes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kamino:0.7.0--h4349ce8_0
stdout: kamino.out
