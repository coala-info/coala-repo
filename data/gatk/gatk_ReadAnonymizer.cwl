cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ReadAnonymizer
label: gatk_ReadAnonymizer
doc: |-
  Replace bases in reads with reference bases.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
    once.
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
- id: output
  type: string
  doc: Output bam file.
  inputBinding:
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
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
- id: ref_base_quality
  type:
  - 'null'
  - int
  doc: 'Quality for bases that are set to the reference base. Default value: 60.'
  inputBinding:
    prefix: --ref-base-quality
- id: use_simple_cigar
  type:
  - 'null'
  - boolean
  doc: 'If true, will produce a simplified cigar string (without `=` and `X`). Default
    value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --use-simple-cigar
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_output
  type: File
  doc: Output bam file.
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
