cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmfilter
label: bmfilter
doc: "Filter reads based on word bitmask matches\n\nTool homepage: https://github.com/Ikyy593/BMFilter_ikyy"
inputs:
  - id: chop_length
    type:
      - 'null'
      - int
    doc: Set length to chop short sequences to
    inputBinding:
      position: 101
      prefix: --chop-length
  - id: chop_step
    type:
      - 'null'
      - int
    doc: Set step by which to chop short sequences
    inputBinding:
      position: 101
      prefix: --chop-step
  - id: clip_lowercase
    type:
      - 'null'
      - boolean
    doc: Should lowercase head and tail of each read be clipped
    inputBinding:
      position: 101
      prefix: --clip-lowercase
  - id: clip_n_win
    type:
      - 'null'
      - int
    doc: Clip sequence head or tail as long as it has at least one N per this long
      window
    inputBinding:
      position: 101
      prefix: --clip-N-win
  - id: clip_quality
    type:
      - 'null'
      - int
    doc: Clip sequence head or tail with quality lower then this (for fastq input)
    inputBinding:
      position: 101
      prefix: --clip-quality
  - id: complexity
    type:
      - 'null'
      - int
    doc: Set complexity filter cutoff
    inputBinding:
      position: 101
      prefix: --complexity
  - id: heur_count_long_pct
    type:
      - 'null'
      - string
    doc: Set watermarks for matched word count for long sequences, int % of good words
    inputBinding:
      position: 101
      prefix: --heur-count-long-pct
  - id: heur_count_short_pct
    type:
      - 'null'
      - string
    doc: Set watermarks for matched word count for short sequences, int % of good
      words
    inputBinding:
      position: 101
      prefix: --heur-count-short-pct
  - id: heur_many_words
    type:
      - 'null'
      - int
    doc: Set number of good words which switches watermarks (long/short)
    inputBinding:
      position: 101
      prefix: --heur-many-words
  - id: heur_min_words
    type:
      - 'null'
      - int
    doc: Set minimal word count to apply heuristics
    inputBinding:
      position: 101
      prefix: --heur-min-words
  - id: heur_negligible_length
    type:
      - 'null'
      - int
    doc: Set cutoff for sequences to consider - these and shorter (after clipping)
      will be marked as foreign
    inputBinding:
      position: 101
      prefix: --heur-negligible-length
  - id: heur_run_long_pct
    type:
      - 'null'
      - string
    doc: Set watermarks for longest match run for long sequences, int % of good words
    inputBinding:
      position: 101
      prefix: --heur-run-long-pct
  - id: heur_run_short_pct
    type:
      - 'null'
      - string
    doc: Set watermarks for longest match run for short sequences, int % of good words
    inputBinding:
      position: 101
      prefix: --heur-run-short-pct
  - id: mask_early
    type:
      - 'null'
      - int
    doc: Set mask low complexity before applying heuristics
    inputBinding:
      position: 101
      prefix: --mask-early
  - id: max_ambiguities
    type:
      - 'null'
      - int
    doc: Maximal number of ambiguities per word
    inputBinding:
      position: 101
      prefix: --max-ambiguities
  - id: no_post_len
    type:
      - 'null'
      - int
    doc: Set longest sequence length to ignore postprocessing
    inputBinding:
      position: 101
      prefix: --no-post-len
  - id: post
    type:
      - 'null'
      - boolean
    doc: Produce .short?.fa and .long?.fa files
    inputBinding:
      position: 101
      prefix: --post
  - id: post_clipped
    type:
      - 'null'
      - boolean
    doc: Put clipped versions of sequences to output .fa files
    inputBinding:
      position: 101
      prefix: --post-clipped
  - id: post_low_complexity
    type:
      - 'null'
      - int
    doc: Should 'unknown' low complexity reads be sent to post processing
    inputBinding:
      position: 101
      prefix: --post-low-complexity
  - id: quality_channels
    type:
      - 'null'
      - int
    doc: Number of quality channers for reads (0|1)
    inputBinding:
      position: 101
      prefix: --quality-channels
  - id: read_1
    type:
      - 'null'
      - type: array
        items: File
    doc: Fasta or fastq (for -q1) file with reads, may be repeated
    inputBinding:
      position: 101
      prefix: --read-1
  - id: read_2
    type:
      - 'null'
      - type: array
        items: File
    doc: Fasta or fastq (for -q1) file with read pair mates, if used should be repeated
      as many times as -1 is
    inputBinding:
      position: 101
      prefix: --read-2
  - id: report
    type:
      - 'null'
      - boolean
    doc: Produce .report file
    inputBinding:
      position: 101
      prefix: --report
  - id: short_seq
    type:
      - 'null'
      - int
    doc: Set sequence length to consider it as short for postprocessing
    inputBinding:
      position: 101
      prefix: --short-seq
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Produce .tag file
    inputBinding:
      position: 101
      prefix: --tag
  - id: use_mmap
    type:
      - 'null'
      - boolean
    doc: Use mmap for word bitmask (slow unless used for few reads; intended for debug)
    inputBinding:
      position: 101
      prefix: --use-mmap
  - id: word_bitmask
    type:
      - 'null'
      - type: array
        items: File
    doc: Word bitmask file (may be repeated)
    inputBinding:
      position: 101
      prefix: --word-bitmask
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output base name (suffixes will be added to it)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmfilter:3.101--hfc679d8_2
