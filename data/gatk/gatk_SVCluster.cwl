cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - SVCluster
label: gatk_SVCluster
doc: |-
  Clusters structural variants

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output VCF
  - id: ploidy_table
    type: File
    inputBinding:
      position: 101
      prefix: --ploidy-table
    doc: Sample ploidy table (.tsv)
  - id: reference
    type: File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence file
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: variant
    type:
      type: array
      items: File
      inputBinding:
        prefix: --variant
    inputBinding:
      position: 101
    doc: One or more VCF files containing variants This argument must be specified
      at least once.
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: algorithm
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --algorithm
    doc: 'Clustering algorithm Default value: SINGLE_LINKAGE. Possible values: {DEFRAGMENT_CNV,
      SINGLE_LINKAGE, MAX_CLIQUE}'
  - id: alt_allele_summary_strategy
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --alt-allele-summary-strategy
    doc: 'Strategy to use for choosing a representative alt allele for non-CNV biallelic
      sites with different subtypes. Default value: COMMON_SUBTYPE. Possible values:
      {MOST_SPECIFIC_SUBTYPE, COMMON_SUBTYPE}'
  - id: breakpoint_summary_strategy
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --breakpoint-summary-strategy
    doc: 'Strategy to use for choosing a representative value for a breakpoint cluster.
      Default value: REPRESENTATIVE. Possible values: {MEDIAN_START_MEDIAN_END, MIN_START_MAX_END,
      MAX_START_MIN_END, MEAN_START_MEAN_END, REPRESENTATIVE}'
  - id: default_no_call
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --default-no-call
    doc: 'Default to no-call GT (e.g. ./.) instead of reference alleles (e.g. 0/0)
      when a genotype is not available Default value: false. Possible values: {true,
      false}'
  - id: defrag_padding_fraction
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --defrag-padding-fraction
    doc: 'Padding as a fraction of variant length for CNV defragmentation mode. Default
      value: 0.25.'
  - id: defrag_sample_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --defrag-sample-overlap
    doc: 'Minimum sample overlap fraction. Use instead of --depth-sample-overlap in
      CNV defragmentation mode. Default value: 0.8.'
  - id: depth_breakend_window
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --depth-breakend-window
    doc: 'Depth/Depth window size for breakend proximity Default value: 10000000.'
  - id: depth_interval_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --depth-interval-overlap
    doc: 'Depth/Depth interval reciprocal overlap fraction Default value: 0.8.'
  - id: depth_sample_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --depth-sample-overlap
    doc: 'Depth/Depth shared sample overlap fraction Default value: 0.0.'
  - id: depth_size_similarity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --depth-size-similarity
    doc: 'Depth/Depth size similarity Default value: 0.0.'
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: enable_cnv
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --enable-cnv
    doc: 'Enable clustering DEL/DUP variants together as CNVs (does not apply to CNV
      defragmentation) Default value: false. Possible values: {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: fast_mode
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --fast-mode
    doc: 'Fast mode. Drops hom-ref and missing genotype fields and emits them as missing.
      Default value: false. Possible values: {true, false}'
  - id: flag_field_logic
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --flag-field-logic
    doc: 'Logic for collapsing Flag type INFO and FORMAT fields Default value: OR.
      Possible values: {AND, OR, ALWAYS_FALSE}'
  - id: input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument may be specified 0 or more
      times.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-records-in-ram
    doc: 'When writing VCF files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk. Increasing this number reduces
      the number of file handles needed to sort a VCF file, and increases the amount
      of RAM needed. Default value: 10000.'
  - id: mixed_breakend_window
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --mixed-breakend-window
    doc: 'Depth/PESR window size for breakend proximity Default value: 1000.'
  - id: mixed_interval_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --mixed-interval-overlap
    doc: 'PESR/Depth interval reciprocal overlap fraction Default value: 0.8.'
  - id: mixed_sample_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --mixed-sample-overlap
    doc: 'Depth/PESR shared sample overlap fraction Default value: 0.0.'
  - id: mixed_size_similarity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --mixed-size-similarity
    doc: 'Depth/PESR size similarity Default value: 0.0.'
  - id: omit_members
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --omit-members
    doc: 'Omit cluster member ID annotations Default value: false. Possible values:
      {true, false}'
  - id: pesr_breakend_window
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --pesr-breakend-window
    doc: 'PESR/PESR window size for breakend proximity Default value: 500.'
  - id: pesr_interval_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --pesr-interval-overlap
    doc: 'PESR/PESR interval reciprocal overlap fraction Default value: 0.5.'
  - id: pesr_sample_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --pesr-sample-overlap
    doc: 'PESR/PESR shared sample overlap fraction Default value: 0.0.'
  - id: pesr_size_similarity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --pesr-size-similarity
    doc: 'PESR/PESR size similarity Default value: 0.0.'
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
  - id: variant_prefix
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variant-prefix
    doc: If supplied, generate variant IDs with this prefix
  - id: variant_output_filtering
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variant-output-filtering
    doc: 'Restrict the output variants to ones that match the specified intervals
      according to the specified matching mode. Default value: null. STARTS_IN (starts
      within any of the given intervals) ENDS_IN (ends within any of the given intervals)
      OVERLAPS (overlaps any of the given intervals) CONTAINED (contained completely
      within a contiguous block of intervals without overlap) ANYWHERE (no filtering)'
outputs:
  - id: output_output
    type: File
    doc: Output VCF
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
