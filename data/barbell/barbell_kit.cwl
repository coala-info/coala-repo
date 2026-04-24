cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barbell
  - kit
label: barbell_kit
doc: "Run a preset\n\nTool homepage: https://github.com/rickbeeloo/barbell"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Edit cost beyond read boundaries
    inputBinding:
      position: 101
      prefix: --alpha
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
    type: string
    doc: Kit to use (e.g. SQK-RBK114-24)
    inputBinding:
      position: 101
      prefix: --kit
  - id: maximize
    type:
      - 'null'
      - boolean
    doc: Add more 'risky' patterns to demuxing to maximize assigned reads
    inputBinding:
      position: 101
      prefix: --maximize
  - id: min_score
    type:
      - 'null'
      - float
    doc: Fraction compared to 'perfect' match score for top candidate
    inputBinding:
      position: 101
      prefix: --min-score
  - id: min_score_diff
    type:
      - 'null'
      - float
    doc: Fraction difference between top 2 candidates
    inputBinding:
      position: 101
      prefix: --min-score-diff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
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
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output)
  - id: failed_out
    type:
      - 'null'
      - File
    doc: Write ids of failed trimmed reads to this file
    outputBinding:
      glob: $(inputs.failed_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
