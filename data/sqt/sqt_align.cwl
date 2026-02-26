cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - align
label: sqt_align
doc: "Compare two strings\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: sequence1
    type: string
    doc: "Sequence or path to FASTA file. If FASTA, only the\n                   \
      \     first sequence is used."
    inputBinding:
      position: 1
  - id: sequence2
    type: string
    doc: "Sequence or path to FASTA file. If FASTA, only the\n                   \
      \     first sequence is used."
    inputBinding:
      position: 2
  - id: max_error_rate
    type:
      - 'null'
      - float
    doc: "Switch to cutadapt algorithm (also enables\n                        --semiglobal).
      No alignment will be printed."
    inputBinding:
      position: 103
      prefix: --max-error-rate
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Output a merged sequence (also enables --semiglobal)
    inputBinding:
      position: 103
      prefix: --merge
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: "Run a semi-global alignment (for detecting overlaps).\n                \
      \        Default: global alignment."
    inputBinding:
      position: 103
      prefix: --overlap
  - id: rc
    type:
      - 'null'
      - boolean
    doc: "Run the alignment also with the reverse-complement of\n                \
      \        the second sequence"
    inputBinding:
      position: 103
      prefix: --rc
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: "Run the alignment also with the reverse-complement of\n                \
      \        the second sequence"
    inputBinding:
      position: 103
      prefix: --reverse-complement
  - id: semiglobal
    type:
      - 'null'
      - boolean
    doc: "Run a semi-global alignment (for detecting overlaps).\n                \
      \        Default: global alignment."
    inputBinding:
      position: 103
      prefix: --semiglobal
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_align.out
