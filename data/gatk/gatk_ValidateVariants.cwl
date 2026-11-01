cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ValidateVariants
label: gatk_ValidateVariants
doc: |-
  Validates a VCF file with an extra strict set of criteria.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
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
- id: dbsnp
  type:
  - 'null'
  - File
  doc: dbSNP file
  inputBinding:
    prefix: --dbsnp
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: do_not_validate_filtered_records
  type:
  - 'null'
  - boolean
  doc: 'skip validation on filtered records Default value: false. Possible values:
    {true, false} Cannot be used in conjunction with argument(s) VALIDATE_GVCF (gvcf)
    FAIL_ON_OVERLAP (no-overlaps)'
  inputBinding:
    prefix: --do-not-validate-filtered-records
    valueFrom: '$(self ? ''true'' : ''false'')'
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
- id: fail_gvcf_on_overlap
  type:
  - 'null'
  - boolean
  doc: 'Fail if GVCF contains positions that overlap (except two variants overlapping)
    Default value: false. Possible values: {true, false} Cannot be used in conjunction
    with argument(s) DO_NOT_VALIDATE_FILTERED (do-not-validate-filtered-records)'
  inputBinding:
    prefix: --fail-gvcf-on-overlap
    valueFrom: '$(self ? ''true'' : ''false'')'
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
- id: validate_gvcf
  type:
  - 'null'
  - boolean
  doc: 'Validate this file as a GVCF Default value: false. Possible values: {true,
    false} Cannot be used in conjunction with argument(s) DO_NOT_VALIDATE_FILTERED
    (do-not-validate-filtered-records)'
  inputBinding:
    prefix: --validate-GVCF
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: validation_type_to_exclude
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --validation-type-to-exclude
  doc: 'which validation type to exclude from a full strict validation This argument
    may be specified 0 or more times. Possible values: {ALL, REF, IDS, ALLELES, CHR_COUNTS}'
- id: warn_on_errors
  type:
  - 'null'
  - boolean
  doc: 'just emit warnings on errors instead of terminating the run at the first instance
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --warn-on-errors
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs: []
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
