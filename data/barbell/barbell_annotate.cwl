cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barbell
  - annotate
label: barbell_annotate
doc: "Annotate FASTQ files with barcode information\n\nTool homepage: https://github.com/rickbeeloo/barbell"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Edit cost beyond read boundaries
    default: 0.4
    inputBinding:
      position: 101
      prefix: --alpha
  - id: barcode_types
    type:
      - 'null'
      - string
    doc: 'Barcode types (comma-separated: Ftag,Rtag) matching your query file (-q)'
    default: Ftag
    inputBinding:
      position: 101
      prefix: --barcode-types
  - id: flank_max_errors
    type:
      - 'null'
      - int
    doc: Flank maximum erors in flank, ONLY set manually when you know what you are
      doing
    inputBinding:
      position: 101
      prefix: --flank-max-errors
  - id: input
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: --input
  - id: kit
    type:
      - 'null'
      - string
    doc: Kit name (e.g. SQK-RBK114-24). Conflicts with --queries/--barcode-types
    inputBinding:
      position: 101
      prefix: --kit
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Barcode: fraction compared to 'perfect' match score for top candidate"
    default: 0.2
    inputBinding:
      position: 101
      prefix: --min-score
  - id: min_score_diff
    type:
      - 'null'
      - float
    doc: 'Barcode: fraction difference between top 2 candidates'
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-score-diff
  - id: queries
    type:
      - 'null'
      - string
    doc: Query files (comma-separated paths)
    inputBinding:
      position: 101
      prefix: --queries
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_extended
    type:
      - 'null'
      - boolean
    doc: Also use extended templates (if using kit), i.e. detect fusions, breaks,
      etc. (slower)
    inputBinding:
      position: 101
      prefix: --use-extended
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
