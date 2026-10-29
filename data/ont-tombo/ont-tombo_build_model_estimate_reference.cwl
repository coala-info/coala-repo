cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - build_model
  - estimate_reference
label: ont-tombo_build_model_estimate_reference
doc: "Estimate reference tombo model derived from the provided reads.\n\nTool homepage: https://github.com/nanoporetech/tombo"
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
  - id: tombo_model_filename
    type: string
    doc: "Filename to save Tombo model."
    inputBinding:
      position: 101
      prefix: "--tombo-model-filename"
  - id: estimate_mean
    type:
      - 'null'
      - boolean
    doc: "Use the mean instead of median for model level estimation. Note: This can cause poor fits due to outliers"
    inputBinding:
      position: 101
      prefix: "--estimate-mean"
  - id: kmer_specific_sd
    type:
      - 'null'
      - boolean
    doc: "Estimate standard deviation for each k-mers individually."
    inputBinding:
      position: 101
      prefix: "--kmer-specific-sd"
  - id: upstream_bases
    type:
      - 'null'
      - int
    doc: "Upstream bases in k-mer. Default: 1"
    inputBinding:
      position: 101
      prefix: "--upstream-bases"
  - id: downstream_bases
    type:
      - 'null'
      - int
    doc: "Downstream bases in k-mer. Default: 2"
    inputBinding:
      position: 101
      prefix: "--downstream-bases"
  - id: minimum_test_reads
    type:
      - 'null'
      - int
    doc: "Number of reads required at a position to perform significance testing or contribute to model estimation. Default: 10"
    inputBinding:
      position: 101
      prefix: "--minimum-test-reads"
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: "Maximum mean coverage per region when estimating k-mer model (limits compute time for deep samples). Default: 100"
    inputBinding:
      position: 101
      prefix: "--coverage-threshold"
  - id: minimum_kmer_observations
    type:
      - 'null'
      - int
    doc: "Number of each k-mer observations required in order to produce a reference (genomic locations for standard reference and per-read for alternative reference). Default: 5"
    inputBinding:
      position: 101
      prefix: "--minimum-kmer-observations"
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
  - id: model_file
    type: File
    doc: "Estimated Tombo model file"
    outputBinding:
      glob: "$(inputs.tombo_model_filename)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
