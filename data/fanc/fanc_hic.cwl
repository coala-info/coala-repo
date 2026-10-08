cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - hic
label: fanc_hic
doc: "Process, filter, and correct Hic files: turn FAN-C Pairs into a Hic object, merge, bin, filter and normalise it.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input FAN-C Pairs or Hic files. They are merged, then binned, filtered and corrected."
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: "Output FAN-C Hic file. Leave empty to bin, filter and correct a single Hic object in place (a writable copy is returned)."
    inputBinding:
      position: 2
  - id: bin_size
    type:
      - 'null'
      - string
    doc: "Bin size in base pairs. You can use human-readable formats,such as 10k, or 1mb. If omitted, the command will end after the merging step."
    inputBinding:
      position: 20
      prefix: --bin-size
  - id: filter_low_coverage
    type:
      - 'null'
      - float
    doc: "Filter bins with low coverage (lower than specified absolute number of contacts)"
    inputBinding:
      position: 20
      prefix: --filter-low-coverage
  - id: filter_low_coverage_relative
    type:
      - 'null'
      - float
    doc: "Filter bins using a relative low coverage threshold (lower than the specified fraction of the median contact count)"
    inputBinding:
      position: 20
      prefix: --filter-low-coverage-relative
  - id: low_coverage_auto
    type:
      - 'null'
      - boolean
    doc: "Filter bins with \"low coverage\" (under 10% of median coverage for all non-zero bins)"
    inputBinding:
      position: 20
      prefix: --low-coverage-auto
  - id: diagonal
    type:
      - 'null'
      - int
    doc: "Filter bins along the diagonal up to this specified distance. Use 0 for only filtering the diagonal."
    inputBinding:
      position: 20
      prefix: --diagonal
  - id: marginals_plot
    type:
      - 'null'
      - string
    doc: "Plot Hi-C marginals to determine low coverage thresholds."
    inputBinding:
      position: 20
      prefix: --marginals-plot
  - id: reset_filters
    type:
      - 'null'
      - boolean
    doc: "Remove all filters from the Hic object."
    inputBinding:
      position: 20
      prefix: --reset-filters
  - id: downsample
    type:
      - 'null'
      - string
    doc: "Downsample a binned Hi-C object before filtering and correcting. Sample size or reference Hi-C object. If sample size is < 1,will be interpreted as a fraction of valid pairs."
    inputBinding:
      position: 20
      prefix: --downsample
  - id: subset
    type:
      - 'null'
      - string
    doc: "Comma-separated list of regions that will be used in the output Hic object. All contacts between these regions will be in the output object. For example, \"chr1,chr3\" will result in a Hic object with all regions in chromosomes 1 and 3, plus all contacts within chromosome 1, all contacts within chromosome 3, and all contacts between chromosome 1 and 3. \"chr1\" will only contain regions and contactswithin chromosome 1."
    inputBinding:
      position: 20
      prefix: --subset
  - id: ice_correct
    type:
      - 'null'
      - boolean
    doc: "DEPRECATED. Use ICE iterative correction on the binned Hic matrix"
    inputBinding:
      position: 20
      prefix: --ice-correct
  - id: kr_correct
    type:
      - 'null'
      - boolean
    doc: "DEPRECATED. Use Knight-Ruiz matrix balancing to correct the binned Hic matrix"
    inputBinding:
      position: 20
      prefix: --kr-correct
  - id: normalise
    type:
      - 'null'
      - boolean
    doc: "Normalise Hi-C matrix according to --norm-method"
    inputBinding:
      position: 20
      prefix: --normalise
  - id: norm_method
    type:
      - 'null'
      - string
    doc: "Normalisation method used for -n. Options are: KR (default) = Knight-Ruiz matrix balancing (Fast, accurate, but memory-intensive normalisation); ICE = ICE matrix balancing (less accurate, but more memory- efficient); VC = vanilla coverage (a single round of ICE balancing);VC-SQRT = vanilla coverage square root (reduces overcorrection compared to VC)"
    inputBinding:
      position: 20
      prefix: --norm-method
  - id: whole_matrix
    type:
      - 'null'
      - boolean
    doc: "Correct the whole matrix at once, rather than individual chromosomes."
    inputBinding:
      position: 20
      prefix: --whole-matrix
  - id: restore_coverage
    type:
      - 'null'
      - boolean
    doc: "Restore coverage to the original total number of reads. Otherwise matrix entries will be contact probabilities."
    inputBinding:
      position: 20
      prefix: --restore-coverage
  - id: only_inter
    type:
      - 'null'
      - boolean
    doc: "Calculate bias vector only on inter-chromosomal contacts. Ignores all intra-chromosomal contacts. Always uses whole-matrix balancing, i.e. implicitly sets -w"
    inputBinding:
      position: 20
      prefix: --only-inter
  - id: statistics
    type:
      - 'null'
      - string
    doc: "Path for saving filter statistics"
    inputBinding:
      position: 20
      prefix: --statistics
  - id: statistics_plot
    type:
      - 'null'
      - string
    doc: "Path for saving filter statistics plot (PDF)"
    inputBinding:
      position: 20
      prefix: --statistics-plot
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Limit output Hic object to these chromosomes. Only available in conjunction with \"-b\" option."
    inputBinding:
      position: 20
      prefix: --chromosomes
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "If the specified output file exists, it will be overwritten without warning."
    inputBinding:
      position: 20
      prefix: --force-overwrite
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (currently used for binning only)"
    inputBinding:
      position: 20
      prefix: --threads
  - id: deepcopy
    type:
      - 'null'
      - boolean
    doc: "Deep copy Hi-C file. Can be used"
    inputBinding:
      position: 20
      prefix: --deepcopy
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: hic
    type: File
    doc: "FAN-C Hic object."
    outputBinding:
      glob: "$(inputs.output ? inputs.output : inputs.input[0].basename)"
  - id: marginals_plot_file
    type:
      - 'null'
      - File
    doc: "Hi-C marginals plot."
    outputBinding:
      glob: $(inputs.marginals_plot)
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: "Filter statistics."
    outputBinding:
      glob: $(inputs.statistics)
  - id: statistics_plot_file
    type:
      - 'null'
      - File
    doc: "Filter statistics plot (PDF)."
    outputBinding:
      glob: $(inputs.statistics_plot)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${ if (inputs.output == null) { return [{"entry": inputs.input[0], "writable": true}]; } return []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
