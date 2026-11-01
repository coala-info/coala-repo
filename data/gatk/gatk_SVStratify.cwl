cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - SVStratify
label: gatk_SVStratify
doc: |-
  Annotates variants by SV type, size, and reference tracks

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output path. Must be a directory if using --split-output
  - id: stratify_config
    type: File
    inputBinding:
      position: 101
      prefix: --stratify-config
    doc: Stratification configuration file (.tsv)
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
  - id: allow_multiple_matches
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --allow-multiple-matches
    doc: 'Do not enforce mutual exclusivity for each stratification group Default
      value: false. Possible values: {true, false}'
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
  - id: output_prefix
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output-prefix
    doc: Prefix for output filenames, only if using --split-output
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
  - id: split_output
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --split-output
    doc: 'Split output into multiple VCFs, one per stratification group. If used,
      then --output must be the output directory and --output-prefix must be provided.
      Default value: false. Possible values: {true, false}'
  - id: stratify_num_breakpoint_overlaps
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --stratify-num-breakpoint-overlaps
    doc: 'Minimum number of variant endpoint overlaps for tracks Default value: 1.'
  - id: stratify_num_breakpoint_overlaps_interchromosomal
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --stratify-num-breakpoint-overlaps-interchromosomal
    doc: 'Minimum number of breakpoint overlaps for tracks for interchromosomal variants
      (e.g. BNDs) Default value: 1.'
  - id: stratify_overlap_fraction
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --stratify-overlap-fraction
    doc: 'Minimum overlap fraction for tracks Default value: 0.0.'
  - id: track_intervals
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --track-intervals
    inputBinding:
      position: 101
    doc: Track intervals file. Can be specified multiple times. This argument may
      be specified 0 or more times.
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: track_name
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --track-name
    inputBinding:
      position: 101
    doc: Track names. Must be once for each --track-intervals This argument may be
      specified 0 or more times.
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
    doc: Output path. Must be a directory if using --split-output
    outputBinding:
      glob: $(inputs.output)
  - id: output_prefix_out
    type:
      type: array
      items: File
    doc: Prefix for output filenames, only if using --split-output
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
