cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - SVConcordance
label: gatk_SVConcordance
doc: |-
  Annotates structural variant genotype concordance

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: evaluation
    type: File
    inputBinding:
      position: 101
      prefix: --evaluation
    doc: A VCF containing variants to be compared to the truth
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output VCF
  - id: truth
    type: File
    inputBinding:
      position: 101
      prefix: --truth
    doc: A VCF containing truth variants
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: clustering_config
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --clustering-config
    doc: Configuration file (.tsv) containing the clustering parameters for each group
  - id: confidence
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --confidence
    doc: TO BE IMPLEMENTED
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
      of RAM needed. Default value: 1000.'
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
  - id: stratify_config
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --stratify-config
    doc: Stratification configuration file (.tsv)
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
