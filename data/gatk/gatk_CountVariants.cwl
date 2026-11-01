cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CountVariants
label: gatk_CountVariants
doc: |-
  This tool counts the variant records in a VCF file, regardless of filter status. Because it counts the number of rows in the VCF, it does not necessarily reflect the number of variant alleles. The count is printed to standard output (and may optionally be written to a file)

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
- id: output
  type:
  - 'null'
  - string
  doc: Optional output file
  inputBinding:
    prefix: --output
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
  type:
  - 'null'
  - File
  doc: Optional output file
  outputBinding:
    glob: $(inputs.output)
- id: count
  type: stdout
  doc: Standard output of the tool
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
stdout: count_variants_stdout.txt
