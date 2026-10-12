cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - detect_modifications
  - aggregate_per_read_stats
label: ont-tombo_detect_modifications_aggregate_per_read_stats
doc: "Aggregate Tombo per-read statistics to produce a genomic base statistics file.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: per_read_statistics_filename
    type: File
    doc: "Binary file containing per-read statistics from statistical testing."
    inputBinding:
      position: 101
      prefix: "--per-read-statistics-filename"
  - id: statistics_filename
    type: string
    doc: "File to save/load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filename"
  - id: single_read_threshold
    type: float[]
    doc: "P-value or log likelihood ratio threshold when computing fraction of significant reads at each genomic position. If two values are provided, statistics between these values are not considered."
    inputBinding:
      position: 101
      prefix: "--single-read-threshold"
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: "Number of reads required at a position to perform significance testing or contribute to model estimation. Default: 1"
    inputBinding:
      position: 101
      prefix: "--minimum-test-reads"
  - id: coverage_dampen_counts
    type:
      - 'null'
      - float[]
    doc: "Dampen fraction modified estimates for low coverage sites. Two parameters are unmodified and modified pseudo read counts. This is equivalent to a beta prior on the fraction estimate. Set to \"0 0\" to disable dampened fraction estimation. Default: [2, 0]"
    inputBinding:
      position: 101
      prefix: "--coverage-dampen-counts"
  - id: num_most_significant_stored
    type:
      - 'null'
      - int
    doc: "Number of the most significant sites to store for faster access. If a longer list of most significant sites is required the list must be re-computed from all batches. Very large values can increase RAM usage. Default: 100000"
    inputBinding:
      position: 101
      prefix: "--num-most-significant-stored"
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes. Default: 1"
    inputBinding:
      position: 101
      prefix: "--processes"
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: "FAST5 group created by resquiggle command. Default: RawGenomeCorrected_000"
    inputBinding:
      position: 101
      prefix: "--corrected-group"
  - id: basecall_subgroups
    type:
      - 'null'
      - string[]
    doc: "FAST5 subgroup(s) (under /Analyses/[--basecall- group]/) containing basecalls and created within [--corrected-group] containing re-squiggle results. Default: ['BaseCalled_template']"
    inputBinding:
      position: 101
      prefix: "--basecall-subgroups"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: statistics_file
    type: File
    doc: "Aggregated genomic base statistics file"
    outputBinding:
      glob: "$(inputs.statistics_filename)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
