cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - detect_modifications
  - model_sample_compare
label: ont-tombo_detect_modifications_model_sample_compare
doc: "Test for shifts in raw signal against levels estimated from a canonical/control sample (PCR/IVT) at each reference position.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: statistics_file_basename
    type: string
    doc: "File base name to save base by base statistics from testing. Filenames will be [--statistics-file- basename].[--alternate-bases]?.tombo.stats"
    inputBinding:
      position: 101
      prefix: "--statistics-file-basename"
  - id: control_fast5_basedirs
    type:
      type: array
      items: Directory
    doc: "Set of directories containing fast5 files for control reads, containing only canonical nucleotides."
    inputBinding:
      position: 101
      prefix: "--control-fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: sample_only_estimates
    type:
      - 'null'
      - boolean
    doc: "Only use canonical sample to estimate expected signal level and spread. Default: Use canonical model to improve estimtates (esp. for low coverage regions) using baysian posterior estimates."
    inputBinding:
      position: 101
      prefix: "--sample-only-estimates"
  - id: model_prior_weights
    type:
      - 'null'
      - type: array
        items: float
    doc: "Prior weights (one each for mean and spread) applied to canonical base model for estimating posterior model parameters for sample comparison. Default: [5, 40]"
    inputBinding:
      position: 101
      prefix: "--model-prior-weights"
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "Explicitly select canonical DNA model. Default: Automatically determine from FAST5s"
    inputBinding:
      position: 101
      prefix: "--dna"
  - id: rna
    type:
      - 'null'
      - boolean
    doc: "Explicitly select canonical RNA model. Default: Automatically determine from FAST5s"
    inputBinding:
      position: 101
      prefix: "--rna"
  - id: fishers_method_context
    type:
      - 'null'
      - int
    doc: "Number of context bases up and downstream over which to compute Fisher's method combined p-values. Note: Not applicable for alternative model likelihood ratio tests. Default: 1."
    inputBinding:
      position: 101
      prefix: "--fishers-method-context"
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: "Number of reads required at a position to perform significance testing or contribute to model estimation. Default: 1"
    inputBinding:
      position: 101
      prefix: "--minimum-test-reads"
  - id: single_read_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: "P-value threshold when computing fraction of significant reads at each genomic position. If two values are provided, statistics between these values are not considered. Default thresholds: DNA:0.15-0.5 , RNA:0.05-0.4"
    inputBinding:
      position: 101
      prefix: "--single-read-threshold"
  - id: coverage_dampen_counts
    type:
      - 'null'
      - type: array
        items: float
    doc: "Dampen fraction modified estimates for low coverage sites. Two parameters are unmodified and modified pseudo read counts. This is equivalent to a beta prior on the fraction estimate. Set to \"0 0\" to disable dampened fraction estimation. Default: [2, 0]"
    inputBinding:
      position: 101
      prefix: "--coverage-dampen-counts"
  - id: per_read_statistics_basename
    type:
      - 'null'
      - string
    doc: "Base for binary files containing per-read statistics from statistical testing. Filenames will be [--per- read-statistics-basename].[--alternate- bases]?.tombo.per_read_stats"
    inputBinding:
      position: 101
      prefix: "--per-read-statistics-basename"
  - id: num_most_significant_stored
    type:
      - 'null'
      - int
    doc: "Number of the most significant sites to store for faster access. If a longer list of most significant sites is required the list must be re-computed from all batches. Very large values can increase RAM usage. Default: 100000"
    inputBinding:
      position: 101
      prefix: "--num-most-significant-stored"
  - id: multiprocess_region_size
    type:
      - 'null'
      - int
    doc: "Size of regions over which to multiprocesses statistic computation. For very deep samples a smaller value is recommmended in order to control memory consumption. Default: 10000"
    inputBinding:
      position: 101
      prefix: "--multiprocess-region-size"
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
      - type: array
        items: string
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
  - id: statistics_files
    type:
      type: array
      items: File
    doc: "Statistics and per-read statistics files"
    outputBinding:
      glob: "$([inputs.statistics_file_basename + '*'].concat(inputs.per_read_statistics_basename ? [inputs.per_read_statistics_basename + '*'] : []))"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.control_fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
