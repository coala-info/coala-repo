cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepeatScout
label: repeatscout_RepeatScout
doc: "RepeatScout Version 1.0.7\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs:
  - id: cap_penalty
    type:
      - 'null'
      - int
    doc: cap on penalty for exiting alignment of a sequence
    default: -20
    inputBinding:
      position: 101
      prefix: -cappenalty
  - id: extend_region_size
    type:
      - 'null'
      - int
    doc: size of region to extend left or right
    default: 10000
    inputBinding:
      position: 101
      prefix: -L
  - id: freq_file
    type: File
    doc: file containing l-mer frequency table
    inputBinding:
      position: 101
      prefix: -freq
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: penalty for a gap
    default: -5
    inputBinding:
      position: 101
      prefix: -gap
  - id: lmer_length
    type: int
    doc: length of l-mers to use (must be same as frequency file)
    inputBinding:
      position: 101
      prefix: -l
  - id: match_reward
    type:
      - 'null'
      - int
    doc: reward for a match
    default: 1
    inputBinding:
      position: 101
      prefix: -match
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: maximum number of gaps allowed
    default: 5
    inputBinding:
      position: 101
      prefix: -maxgap
  - id: max_lmer_entropy
    type:
      - 'null'
      - float
    doc: entropy (complexity) threshold for an l-mer to be considered
    default: -0.7
    inputBinding:
      position: 101
      prefix: -maxentropy
  - id: max_occurrences
    type:
      - 'null'
      - int
    doc: cap on the number of sequences to align
    default: 10000
    inputBinding:
      position: 101
      prefix: -maxoccurrences
  - id: max_repeats
    type:
      - 'null'
      - int
    doc: stop work after reporting this number of repeats
    default: 10000
    inputBinding:
      position: 101
      prefix: -maxrepeats
  - id: min_alignment_improvement
    type:
      - 'null'
      - int
    doc: amount that a the alignment needs to improve each step to be considered
      progress
    default: 3
    inputBinding:
      position: 101
      prefix: -minimprovement
  - id: min_reported_length
    type:
      - 'null'
      - int
    doc: minimum required length for a sequence to be reported
    default: 50
    inputBinding:
      position: 101
      prefix: -goodlength
  - id: min_seed_lmers
    type:
      - 'null'
      - int
    doc: stop if fewer than this number of l-mers are found in the seeding phase
    default: 3
    inputBinding:
      position: 101
      prefix: -minthresh
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: penalty for a mismatch
    default: -1
    inputBinding:
      position: 101
      prefix: -mismatch
  - id: ranges_file
    type:
      - 'null'
      - File
    doc: file to save the extended sequence ranges (optional)
    inputBinding:
      position: 101
      prefix: -ranges
  - id: sequence_file
    type: File
    doc: file containing sequence data (FASTA format)
    inputBinding:
      position: 101
      prefix: -sequence
  - id: stop_after_no_progress
    type:
      - 'null'
      - int
    doc: stop the alignment after this number of no-progress columns
    default: 100
    inputBinding:
      position: 101
      prefix: -stopafter
  - id: tandem_distance
    type:
      - 'null'
      - int
    doc: of bases that must intervene between two l-mers for both to be counted
    default: 500
    inputBinding:
      position: 101
      prefix: -tandemdist
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: How verbose do you want it to be?  -vvvv is super-verbose.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: file to write identified consensi to (FASTA format)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
