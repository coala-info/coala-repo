cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CheckReferenceCompatibility
label: gatk_CheckReferenceCompatibility
doc: |-
  Check a BAM/VCF for compatibility against specified references and output a tab-delimited table detailing the compatibility status and relevant information about the status.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: references_to_compare
  type:
    type: array
    items: File
    inputBinding:
      prefix: --references-to-compare
  doc: Reference sequence file(s) to compare.
  inputBinding:
    position: 1
  secondaryFiles:
  - .fai
  - ^.dict
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  inputBinding:
    position: 1
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: output
  type:
  - 'null'
  - string
  default: compat.tsv
  doc: If specified, output reference sequence table in TSV format to this file. Otherwise
    print it to stdout.
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: variant
  type:
  - 'null'
  - File
  doc: A VCF file containing variants
  inputBinding:
    position: 1
    prefix: --variant
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
outputs:
- id: output_file
  type: File
  doc: If specified, output reference sequence table in TSV format to this file. Otherwise
    print it to stdout.
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
