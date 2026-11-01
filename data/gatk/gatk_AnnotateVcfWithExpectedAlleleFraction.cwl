cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- AnnotateVcfWithExpectedAlleleFraction
label: gatk_AnnotateVcfWithExpectedAlleleFraction
doc: |-
  Annotate a multi-sample vcf with expected allele fractions in pooled sequencing given mixing fractions of the different samples in the pool via the formula Expected allele fraction = SUM_samples {mixing_fraction(sample) * [0 if hom ref, 0.5 is het, 1.0 if hom var]}

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: mixing_fractions
  type: File
  doc: The input mixing fractions table
  inputBinding:
    prefix: --mixing-fractions
- id: output
  type: string
  doc: The output annotated VCF file
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
  doc: The output annotated VCF file
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
