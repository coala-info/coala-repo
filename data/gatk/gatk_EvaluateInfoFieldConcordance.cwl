cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- EvaluateInfoFieldConcordance
label: gatk_EvaluateInfoFieldConcordance
doc: |-
  This tool evaluates info fields from an input VCF against a VCF that has been validated and is considered to represent ground truth.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: eval_info_key
  type: string
  doc: Info key from eval vcf
  inputBinding:
    prefix: --eval-info-key
- id: evaluation
  type: File
  doc: A VCF containing variants to be compared to the truth
  inputBinding:
    prefix: --evaluation
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: summary
  type: string
  doc: A table of summary statistics (true positives, sensitivity, etc.)
  inputBinding:
    prefix: --summary
- id: truth
  type: File
  doc: A VCF containing truth variants
  inputBinding:
    prefix: --truth
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: truth_info_key
  type: string
  doc: Info key from truth vcf
  inputBinding:
    prefix: --truth-info-key
- id: confidence
  type:
  - 'null'
  - File
  doc: TO BE IMPLEMENTED
  inputBinding:
    prefix: --confidence
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing This argument may
    be specified 0 or more times.
- id: interval_padding
  type:
  - 'null'
  - int
  doc: 'Amount of padding (in bp) to add to each interval you are including. Default
    value: 0.'
  inputBinding:
    prefix: --interval-padding
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate This argument may be specified
    0 or more times.
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
- id: epsilon
  type:
  - 'null'
  - double
  doc: 'Difference tolerance Default value: 0.1.'
  inputBinding:
    prefix: --epsilon
- id: warn_big_differences
  type:
  - 'null'
  - boolean
  doc: 'If set differences in the info key values greater than epsilon will trigger
    warnings. Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --warn-big-differences
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_summary
  type: File
  doc: A table of summary statistics (true positives, sensitivity, etc.)
  outputBinding:
    glob: $(inputs.summary)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
