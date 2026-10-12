cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - detect_modifications
  - level_sample_compare
label: ont-tombo_detect_modifications_level_sample_compare
doc: "Test for shifts in raw signal against signal level distributions from a canonical/control sample (PCR/IVT) at each reference position.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedirs
    type: Directory[]
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
  - id: alternate_fast5_basedirs
    type: Directory[]
    doc: "Set of directories containing fast5 files for alternate set of reads."
    inputBinding:
      position: 101
      prefix: "--alternate-fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
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
    doc: "Number of reads required at a position to perform significance testing or contribute to model estimation. Default: 50"
    inputBinding:
      position: 101
      prefix: "--minimum-test-reads"
  - id: statistic_type
    type:
      - 'null'
      - string
    doc: "Type of statistical test to apply. Default: \"ks\""
    inputBinding:
      position: 101
      prefix: "--statistic-type"
  - id: store_p_value
    type:
      - 'null'
      - boolean
    doc: "Store p-value instead of effect-size statistic. Statistics are D-statistic (KS-test), deviation from even common language effect size (u-test), and Cohen's D (t-test)."
    inputBinding:
      position: 101
      prefix: "--store-p-value"
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
  - id: statistics_files
    type: File[]
    doc: "Statistics files"
    outputBinding:
      glob: "$(inputs.statistics_file_basename + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.alternate_fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
