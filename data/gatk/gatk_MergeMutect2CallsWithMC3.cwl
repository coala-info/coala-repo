cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- MergeMutect2CallsWithMC3
label: gatk_MergeMutect2CallsWithMC3
doc: |-
  UNSUPPORTED. FOR EVALUATION ONLY. Merge M2 (eval) calls with MC3 (truth)

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
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
- id: output
  type: string
  doc: Merged vcf.
  inputBinding:
    prefix: --output
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
outputs:
- id: output_output
  type: File
  doc: Merged vcf.
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
