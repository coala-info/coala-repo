cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobloomcategorizer
label: biobloomtools_biobloomcategorizer
doc: "Categorize Sequences. The input format may be FASTA, FASTQ, and compressed gz.\n
  \nTool homepage: https://github.com/bcgsc/biobloom"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence files (FASTA, FASTQ, or gz)
    inputBinding:
      position: 1
  - id: best_hit
    type:
      - 'null'
      - boolean
    doc: The best hit is used rather than the score (-s) threshold. Score will be
      appended to the header of the output read.
    inputBinding:
      position: 102
      prefix: --best_hit
  - id: chastity
    type:
      - 'null'
      - boolean
    doc: Discard and do not evaluate unchaste reads.
    inputBinding:
      position: 102
      prefix: --chastity
  - id: dust
    type:
      - 'null'
      - boolean
    doc: Filter using dust.
    inputBinding:
      position: 102
      prefix: --dust
  - id: fa
    type:
      - 'null'
      - boolean
    doc: Output categorized reads in Fasta files.
    inputBinding:
      position: 102
      prefix: --fa
  - id: file_list
    type:
      - 'null'
      - File
    doc: A file of list of file pairs to run in parallel. Should only be used when
      the number of input files is large.
    inputBinding:
      position: 102
      prefix: --file_list
  - id: filter_files
    type:
      type: array
      items: File
    doc: List of filter files to use. Required option. eg. "filter1.bf filter2.bf"
    inputBinding:
      position: 102
      prefix: --filter_files
  - id: fq
    type:
      - 'null'
      - boolean
    doc: Output categorized reads in Fastq files.
    inputBinding:
      position: 102
      prefix: --fq
  - id: gz_output
    type:
      - 'null'
      - boolean
    doc: Outputs all output files in compressed gzip.
    inputBinding:
      position: 102
      prefix: --gz_output
  - id: inclusive
    type:
      - 'null'
      - boolean
    doc: If one paired read matches, both reads will be included in the filter.
    inputBinding:
      position: 102
      prefix: --inclusive
  - id: interval
    type:
      - 'null'
      - int
    doc: Interval to report file processing status
    default: 10000000
    inputBinding:
      position: 102
      prefix: --interval
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Inverts the output of -d (everything but first filter).
    inputBinding:
      position: 102
      prefix: --inverse
  - id: no_chastity
    type:
      - 'null'
      - boolean
    doc: Do not discard unchaste reads.
    inputBinding:
      position: 102
      prefix: --no-chastity
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Use ordered filtering. Order of filters matters (filters listed first have
      higher priority).
    inputBinding:
      position: 102
      prefix: --ordered
  - id: paired_mode
    type:
      - 'null'
      - boolean
    doc: Uses paired-end information.
    inputBinding:
      position: 102
      prefix: --paired_mode
  - id: score
    type:
      - 'null'
      - float
    doc: Score threshold for matching. N may be either a floating point score between
      0 and 1 or a positive integer representing the minimum match length in bases.
    default: 0.15
    inputBinding:
      position: 102
      prefix: --score
  - id: score_type
    type:
      - 'null'
      - string
    doc: Can be set to 'harmonic' scoring or 'binomial' scoring.
    default: simple
    inputBinding:
      position: 102
      prefix: --score_type
  - id: stdout_filter
    type:
      - 'null'
      - boolean
    doc: Outputs all matching reads to stdout for the first filter listed by -f.
    inputBinding:
      position: 102
      prefix: --stdout_filter
  - id: streak
    type:
      - 'null'
      - int
    doc: The number of hits tiling in second pass needed to jump several tiles upon
      a miss.
    default: 3
    inputBinding:
      position: 102
      prefix: --streak
  - id: t_dust
    type:
      - 'null'
      - int
    doc: T parameter for dust.
    default: 20
    inputBinding:
      position: 102
      prefix: --T_dust
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_dust
    type:
      - 'null'
      - int
    doc: Window size for dust.
    default: 64
    inputBinding:
      position: 102
      prefix: --window_dust
  - id: with_score
    type:
      - 'null'
      - boolean
    doc: Output multimatches with scores in the order of filter.
    inputBinding:
      position: 102
      prefix: --with_score
outputs:
  - id: prefix
    type:
      - 'null'
      - File
    doc: Output prefix to use. Otherwise will output to current directory.
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobloomtools:2.3.5--h077b44d_6
