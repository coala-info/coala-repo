cwlVersion: v1.2
class: CommandLineTool
baseCommand: pear
label: pear
doc: "PEAR: a fast and accurate Illumina Paired-End reAd mergeR\n\nTool homepage:
  https://github.com/pear-devs/pear-desktop"
inputs:
  - id: cap
    type:
      - 'null'
      - int
    doc: Specify the upper bound for the resulting quality score. If set to zero,
      capping is disabled.
    inputBinding:
      position: 101
      prefix: --cap
  - id: empirical_freqs
    type:
      - 'null'
      - boolean
    doc: 'Disable empirical base frequencies. (default: use empirical base frequencies)'
    inputBinding:
      position: 101
      prefix: --empirical-freqs
  - id: forward_fastq
    type: File
    doc: Forward paired-end FASTQ file.
    inputBinding:
      position: 101
      prefix: --forward-fastq
  - id: max_assembly_length
    type:
      - 'null'
      - int
    doc: Specify the maximum possible length of the assembled sequences. Setting this
      value to 0 disables the restriction and assembled sequences may be arbitrary
      long.
    inputBinding:
      position: 101
      prefix: --max-assembly-length
  - id: max_uncalled_base
    type:
      - 'null'
      - float
    doc: Specify the maximal proportion of uncalled bases in a read. Setting this
      value to 0 will cause PEAR to discard all reads containing uncalled bases. The
      other extreme setting is 1 which causes PEAR to process all reads independent
      on the number of uncalled bases.
    inputBinding:
      position: 101
      prefix: --max-uncalled-base
  - id: memory
    type:
      - 'null'
      - string
    doc: Specify the amount of memory to be used. The number may be followed by one
      of the letters K, M, or G denoting Kilobytes, Megabytes and Gigabytes, respectively.
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_assembly_length
    type:
      - 'null'
      - int
    doc: Specify the minimum possible length of the assembled sequences. Setting this
      value to 0 disables the restriction and assembled sequences may be arbitrary
      short.
    inputBinding:
      position: 101
      prefix: --min-assembly-length
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Specify the minimum overlap size. The minimum overlap may be set to 1 when
      the statistical test is used. However, further restricting the minimum overlap
      size to a proper value may reduce false-positive assembles.
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: min_trim_length
    type:
      - 'null'
      - int
    doc: Specify the minimum length of reads after trimming the low quality part (see
      option -q).
    inputBinding:
      position: 101
      prefix: --min-trim-length
  - id: nbase
    type:
      - 'null'
      - boolean
    doc: When merging a base-pair that consists of two non-equal bases out of which
      none is degenerate, set the merged base to N and use the highest quality score
      of the two bases
    inputBinding:
      position: 101
      prefix: --nbase
  - id: p_value
    type:
      - 'null'
      - float
    doc: 'Specify a p-value for the statistical test. If the computed p-value of a
      possible assembly exceeds the specified p-value then paired-end read will not
      be assembled. Valid options are: 0.0001, 0.001, 0.01, 0.05 and 1.0. Setting
      1.0 disables the test.'
    inputBinding:
      position: 101
      prefix: --p-value
  - id: phred_base
    type:
      - 'null'
      - int
    doc: Base PHRED quality score.
    inputBinding:
      position: 101
      prefix: --phred-base
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Specify the quality score threshold for trimming the low quality part of
      a read. If the quality scores of two consecutive bases are strictly less than
      the specified threshold, the rest of the read will be trimmed.
    inputBinding:
      position: 101
      prefix: --quality-threshold
  - id: reverse_fastq
    type: File
    doc: Reverse paired-end FASTQ file.
    inputBinding:
      position: 101
      prefix: --reverse-fastq
  - id: score_method
    type:
      - 'null'
      - int
    doc: 'Specify the scoring method. 1. OES with +1 for match and -1 for mismatch.
      2: Assembly score (AS). 3: Ignore quality scores and use +1 for a match and
      -1 for a mismatch.'
    inputBinding:
      position: 101
      prefix: --score-method
  - id: test_method
    type:
      - 'null'
      - int
    doc: 'Specify the type of statistical test. Two options are available. 1: Given
      the minimum allowed overlap, test using the highest OES. 2. Use the acceptance
      probability (m.a.p).'
    inputBinding:
      position: 101
      prefix: --test-method
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pear:0.9.6--hb1d24b7_13
