cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- VariantsToTable
label: gatk_VariantsToTable
doc: |-
  Extract specified fields for each variant in a VCF file to a tab-delimited table, which may be easier to work with than a VCF

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: output
  type: string
  doc: File to which the tab-delimited table is written
  inputBinding:
    prefix: --output
- id: variant
  type: File
  doc: A VCF file containing variants
  inputBinding:
    prefix: --variant
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: as_fields_to_take
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --asFieldsToTake
  doc: The name of an allele-specific INFO field to be split if present This argument
    may be specified 0 or more times.
- id: as_genotype_fields_to_take
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --asGenotypeFieldsToTake
  doc: The name of an allele-specific FORMAT field to be split if present This argument
    may be specified 0 or more times.
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
- id: fields
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --fields
  doc: The name of a standard VCF field or an INFO field to include in the output
    table This argument may be specified 0 or more times.
- id: genotype_fields
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --genotype-fields
  doc: The name of a genotype field to include in the output table This argument may
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
- id: split_multi_allelic
  type:
  - 'null'
  - boolean
  doc: 'Split multi-allelic records into multiple lines Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --split-multi-allelic
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: error_if_missing_data
  type:
  - 'null'
  - boolean
  doc: 'Fail on missing data Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --error-if-missing-data
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: moltenize
  type:
  - 'null'
  - boolean
  doc: 'Produce molten output Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --moltenize
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: show_filtered
  type:
  - 'null'
  - boolean
  doc: 'Include filtered records in the output Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --show-filtered
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_output
  type: File
  doc: File to which the tab-delimited table is written
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
