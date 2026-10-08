cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lra
  - index
label: lra_index
doc: "Build global and local indexes on a genome (writes <genome>.mms and <genome>.gli).\n\nTool homepage: https://github.com/ChaissonLab/LRA"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
inputs:
  - id: genome
    type: File
    doc: Reference genome FASTA file to index; index files are written beside it.
    inputBinding:
      position: 1
  - id: ccs
    type:
      - 'null'
      - boolean
    doc: Index for aligning CCS reads
    inputBinding:
      position: 2
      prefix: -CCS
  - id: clr
    type:
      - 'null'
      - boolean
    doc: Index for aligning CLR reads
    inputBinding:
      position: 2
      prefix: -CLR
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Index for aligning Nanopore reads
    inputBinding:
      position: 2
      prefix: -ONT
  - id: contig
    type:
      - 'null'
      - boolean
    doc: Index for aligning large contigs
    inputBinding:
      position: 2
      prefix: -CONTIG
  - id: minimizer_window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size (10).
    inputBinding:
      position: 2
      prefix: -W
  - id: max_minimizer_frequency
    type:
      - 'null'
      - int
    doc: Maximum minimizer frequency. (default 250 for CLR and ONT reads; 150 for CCS reads, 30 for CONTIG.)
    inputBinding:
      position: 2
      prefix: -F
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size
    inputBinding:
      position: 2
      prefix: -K
  - id: local_window_size
    type:
      - 'null'
      - int
    doc: Local minimizer window size (10).
    inputBinding:
      position: 2
      prefix: -w
  - id: local_max_frequency
    type:
      - 'null'
      - int
    doc: Local maximum minimizer frequency (5).
    inputBinding:
      position: 2
      prefix: -f
  - id: local_word_size
    type:
      - 'null'
      - int
    doc: Local word size (10)
    inputBinding:
      position: 2
      prefix: -k
outputs:
  - id: indexed_genome
    type: File
    doc: The genome FASTA with its LRA index file(s).
    outputBinding:
      glob: $(inputs.genome.basename)
    secondaryFiles:
      - pattern: .mms
        required: true
      - pattern: .gli
        required: true
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
stdout: lra_index.out
