cwlVersion: v1.2
class: CommandLineTool
baseCommand: raven
label: raven-assembler
doc: "Raven is a de novo assembler for long reads (PacBio, Oxford Nanopore). It is
  designed as a modular pipeline for assembling genomic datasets.\n\nTool homepage:
  https://github.com/lbcb-sci/raven"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: Input file in FASTA/FASTQ format (can be compressed with gzip)
    inputBinding:
      position: 1
  - id: disable_checkpoints
    type:
      - 'null'
      - boolean
    doc: disable checkpoint file creation
    inputBinding:
      position: 102
      prefix: --disable-checkpoints
  - id: frequency
    type:
      - 'null'
      - float
    doc: threshold for ignoring most frequent kmers
    inputBinding:
      position: 102
      prefix: --frequency
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: length of kmers used for error correction
    inputBinding:
      position: 102
      prefix: --kmer-len
  - id: polishing_rounds
    type:
      - 'null'
      - int
    doc: number of times polishing is performed
    inputBinding:
      position: 102
      prefix: --polishing-rounds
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: window_len
    type:
      - 'null'
      - int
    doc: length of window used for error correction
    inputBinding:
      position: 102
      prefix: --window-len
  - id: identity
    type:
      - 'null'
      - float
    doc: "threshold for overlap between two reads in order to construct an edge between them (default: 0)"
    inputBinding:
      position: 102
      prefix: --identity
  - id: max_num_overlaps
    type:
      - 'null'
      - int
    doc: "maximum number of overlaps that will be taken during FindOverlapsAndCreatePiles stage (default: 32)"
    inputBinding:
      position: 102
      prefix: --kMaxNumOverlaps
  - id: use_micromizers
    type:
      - 'null'
      - boolean
    doc: "use micromizers instead of minimizers in graph construction (faster and less memory, results could be slightly worse)"
    inputBinding:
      position: 102
      prefix: --use-micromizers
  - id: match
    type:
      - 'null'
      - int
    doc: "score for matching bases (default: 3)"
    inputBinding:
      position: 102
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: "score for mismatching bases (default: -5)"
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: gap
    type:
      - 'null'
      - int
    doc: "gap penalty, must be negative (default: -4)"
    inputBinding:
      position: 102
      prefix: --gap
  - id: min_unitig_size
    type:
      - 'null'
      - int
    doc: "minimal unitig size (default: 9999)"
    inputBinding:
      position: 102
      prefix: --min-unitig-size
  - id: gfa_path
    type:
      - 'null'
      - string
    doc: "file name for the assembly graph in GFA format"
    inputBinding:
      position: 102
      prefix: --graphical-fragment-assembly
  - id: unitig_gfa_path
    type:
      - 'null'
      - string
    doc: "file name for the unitig assembly graph in GFA format"
    inputBinding:
      position: 102
      prefix: --unitig-graphical-fragment-assembly
  - id: resume
    type:
      - 'null'
      - boolean
    doc: "resume previous run from last checkpoint"
    inputBinding:
      position: 102
      prefix: --resume
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: assembly_graph
    type:
      - 'null'
      - File
    doc: Assembly graph in GFA format
    outputBinding:
      glob: $(inputs.gfa_path)
  - id: unitig_graph
    type:
      - 'null'
      - File
    doc: Unitig assembly graph in GFA format
    outputBinding:
      glob: $(inputs.unitig_gfa_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raven-assembler:1.8.3--h5ca1c30_3
stdout: raven-assembler.out
