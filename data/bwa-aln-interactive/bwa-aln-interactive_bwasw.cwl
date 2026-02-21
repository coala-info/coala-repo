cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwasw
label: bwa-aln-interactive_bwasw
doc: "BWA-SW algorithm for long-read alignment\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: target_prefix
    type: string
    doc: Target prefix (index files)
    inputBinding:
      position: 1
  - id: query_fa
    type: File
    doc: Query FASTA/Q file
    inputBinding:
      position: 2
  - id: query2_fa
    type:
      - 'null'
      - File
    doc: Second query FASTA/Q file for paired-end alignment
    inputBinding:
      position: 3
  - id: band_width
    type:
      - 'null'
      - int
    doc: band width
    default: 50
    inputBinding:
      position: 104
      prefix: -w
  - id: copy_comment
    type:
      - 'null'
      - boolean
    doc: copy FASTA/Q comment to SAM output
    inputBinding:
      position: 104
      prefix: -C
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty
    default: 2
    inputBinding:
      position: 104
      prefix: -r
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    default: 5
    inputBinding:
      position: 104
      prefix: -q
  - id: hard_clipping
    type:
      - 'null'
      - boolean
    doc: in SAM output, use hard clipping instead of soft clipping
    inputBinding:
      position: 104
      prefix: -H
  - id: ignore_insert_size
    type:
      - 'null'
      - int
    doc: ignore pairs with insert >=INT for inferring the size distr
    default: 20000
    inputBinding:
      position: 104
      prefix: -I
  - id: length_adjustment_coeff
    type:
      - 'null'
      - float
    doc: coefficient of length-threshold adjustment
    default: 5.5
    inputBinding:
      position: 104
      prefix: -c
  - id: mark_secondary
    type:
      - 'null'
      - boolean
    doc: mark multi-part alignments as secondary
    inputBinding:
      position: 104
      prefix: -M
  - id: mask_level
    type:
      - 'null'
      - float
    doc: mask level
    default: 0.5
    inputBinding:
      position: 104
      prefix: -m
  - id: match_score
    type:
      - 'null'
      - int
    doc: score for a match
    default: 1
    inputBinding:
      position: 104
      prefix: -a
  - id: max_gap_size
    type:
      - 'null'
      - int
    doc: maximum gap size during chaining
    default: 10000
    inputBinding:
      position: 104
      prefix: -G
  - id: max_seeding_interval
    type:
      - 'null'
      - int
    doc: maximum seeding interval size
    default: 3
    inputBinding:
      position: 104
      prefix: -s
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    default: 3
    inputBinding:
      position: 104
      prefix: -b
  - id: score_threshold_ratio
    type:
      - 'null'
      - int
    doc: score threshold divided by a
    default: 30
    inputBinding:
      position: 104
      prefix: -T
  - id: seed_trigger_threshold
    type:
      - 'null'
      - int
    doc: '# seeds to trigger rev aln; 2*INT is also the chaining threshold'
    default: 5
    inputBinding:
      position: 104
      prefix: -N
  - id: skip_pairing
    type:
      - 'null'
      - boolean
    doc: skip Smith-Waterman read pairing
    inputBinding:
      position: 104
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 104
      prefix: -t
  - id: z_best
    type:
      - 'null'
      - int
    doc: Z-best
    default: 1
    inputBinding:
      position: 104
      prefix: -z
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: file to output results to instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
