cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CalculateMixingFractions
label: gatk_CalculateMixingFractions
doc: |-
  Calculate proportions of different samples in a pooled bam by first estimating each sample's mixing fraction as the average alt fraction in the bam of singleton hets belonging to that sample, then normalizing these initial estimates to sum to one.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: output
  type: string
  doc: The output table of samplemixing fractions
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
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
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
outputs:
- id: output_output
  type: File
  doc: The output table of samplemixing fractions
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
