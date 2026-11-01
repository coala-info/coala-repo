cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CondenseDepthEvidence
label: gatk_CondenseDepthEvidence
doc: |-
  Merges adjacent DepthEvidence records.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: depth_evidence
    type: File
    inputBinding:
      position: 101
      prefix: --depth-evidence
    doc: DepthEvidence input file
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: Merged DepthEvidence output file
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
  - id: max_interval_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-interval-size
    doc: 'Maximum interval size Default value: 1000.'
  - id: min_interval_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-interval-size
    doc: 'Minimum interval size Default value: 0.'
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
outputs:
  - id: output_output
    type: File
    doc: Merged DepthEvidence output file
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
