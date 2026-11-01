cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - JointGermlineCNVSegmentation
label: gatk_JointGermlineCNVSegmentation
doc: |-
  Gathers single-sample or multi-sample segmented gCNV VCFs, harmonizes breakpoints, and outputs a cohort VCF with genotypes.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: The combined output VCF
  - id: pedigree
    type: File
    inputBinding:
      position: 101
      prefix: --pedigree
    doc: Pedigree file for samples
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
  - id: autosomal_ref_copy_number
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --autosomal-ref-copy-number
    doc: 'Reference copy-number on autosomal intervals. Default value: 2.'
  - id: breakpoint_summary_strategy
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --breakpoint-summary-strategy
    doc: 'Strategy to use for choosing a representative value for a breakpoint cluster.
      Default value: MEDIAN_START_MEDIAN_END. Possible values: {MEDIAN_START_MEDIAN_END,
      MIN_START_MAX_END, MAX_START_MIN_END, MEAN_START_MEAN_END, REPRESENTATIVE}'
  - id: clustering_breakend_window
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --clustering-breakend-window
    doc: 'Cluster events whose endpoints are within this distance of each other Default
      value: 10000000.'
  - id: clustering_interval_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --clustering-interval-overlap
    doc: 'Minimum interval reciprocal overlap for clustering Default value: 0.8.'
  - id: clustering_size_similarity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --clustering-size-similarity
    doc: 'Minimum size similarity for clustering Default value: 0.0.'
  - id: defragmentation_padding_fraction
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --defragmentation-padding-fraction
    doc: 'Extend events by this fraction on each side when determining overlap to
      merge Default value: 0.25.'
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
  - id: min_sample_set_fraction_overlap
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-sample-set-fraction-overlap
    doc: 'Minimum fraction of common samples for two variants to cluster together
      Default value: 0.0.'
  - id: minimum_qs_score
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --minimum-qs-score
    doc: 'Minimum QS score to combine a variant segment Default value: 20.'
  - id: model_call_intervals
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --model-call-intervals
    doc: gCNV model intervals created with the FilterIntervals tool.
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
  - id: combine_variants_distance
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --combine-variants-distance
    doc: 'Maximum distance for variants to be grouped together Default value: 0.'
  - id: ignore_variants_starting_outside_interval
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --ignore-variants-starting-outside-interval
    doc: 'Restrict variant output to sites that start within provided intervals (only
      applies when an interval is specified) Default value: false. Possible values:
      {true, false}'
  - id: max_distance
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-distance
    doc: 'Maximum distance for variants to be grouped together Default value: 2147483647.'
  - id: ref_padding
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --ref-padding
    doc: 'Number of bases on either side to expand spanning reference window Default
      value: 1.'
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
    doc: The combined output VCF
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
