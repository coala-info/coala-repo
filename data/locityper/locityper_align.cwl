cwlVersion: v1.2
class: CommandLineTool
baseCommand: locityper
label: locityper_align
doc: "Align medium-size sequence to each other.\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs:
  - id: accuracy_level
    type:
      - 'null'
      - int
    doc: Alignment accuracy level (1-9)
    inputBinding:
      position: 101
      prefix: --accuracy
  - id: all_pairs
    type:
      - 'null'
      - boolean
    doc: Find alignments for all pairs.
    inputBinding:
      position: 101
      prefix: --all
  - id: backbone_kmer_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: One or more k-mer sizes (5 <= k <= 127) for backbone alignment, 
      separated by comma
      - 25
      - 51
      - 101
    inputBinding:
      position: 101
      prefix: --backbone
  - id: gap_extend_penalty
    type:
      - 'null'
      - int
    doc: Gap extend penalty
    inputBinding:
      position: 101
      prefix: --gap-extend
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Gap open penalty
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: input_fasta
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Do not complete gaps over this size
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: minimizer
    type:
      - 'null'
      - type: array
        items: int
    doc: (k,w)-minimizers for sequence divergence calculation
      - 15
      - 15
    inputBinding:
      position: 101
      prefix: --minimizer
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for mismatch
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: pairs
    type:
      - 'null'
      - type: array
        items: string
    doc: Find alignments for these pairs (two names separated by comma), many 
      pairs allowed.
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pairs_file
    type:
      - 'null'
      - File
    doc: Find alignments for these pairs (two column file).
    inputBinding:
      position: 101
      prefix: --pairs-file
  - id: skip_divergence_calculation
    type:
      - 'null'
      - boolean
    doc: Skip divergence calculation.
    inputBinding:
      position: 101
      prefix: --skip-div
  - id: temp_prefix
    type:
      - 'null'
      - Directory
    doc: Prefix for temporary files (for multiple threads).
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold_divergence
    type:
      - 'null'
      - float
    doc: Do not align sequences with minimizer divergence >= NUM [0.5]. Use -D 1
      to align everything.
    inputBinding:
      position: 101
      prefix: --thresh-div
outputs:
  - id: output_paf
    type: File
    doc: Output PAF[.gz] file.
    outputBinding:
      glob: $(inputs.output_paf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
