cwlVersion: v1.2
class: CommandLineTool
baseCommand: lra_global
label: lra_global
doc: "Index global reference for aligning reads or contigs\n\nTool homepage: https://github.com/ChaissonLab/LRA"
inputs:
  - id: input_file
    type: File
    doc: Input reference FASTA file
    inputBinding:
      position: 1
  - id: ccs_reads
    type:
      - 'null'
      - boolean
    doc: Index for aligning CCS reads
    inputBinding:
      position: 102
      prefix: -CCS
  - id: clr_reads
    type:
      - 'null'
      - boolean
    doc: Index for aligning CLR reads
    inputBinding:
      position: 102
      prefix: -CLR
  - id: contigs
    type:
      - 'null'
      - boolean
    doc: Index for aligning large contigs
    inputBinding:
      position: 102
      prefix: -CONTIG
  - id: max_minimizer_frequency
    type:
      - 'null'
      - int
    doc: Maximum minimizer frequency
    inputBinding:
      position: 102
      prefix: -F
  - id: minimizer_window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size
    inputBinding:
      position: 102
      prefix: -W
  - id: nanopore_reads
    type:
      - 'null'
      - boolean
    doc: Index for aligning Nanopore reads
    inputBinding:
      position: 102
      prefix: -ONT
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size
    inputBinding:
      position: 102
      prefix: -K
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
stdout: lra_global.out
