cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GatherVcfs
label: gatk_GatherVcfs
doc: |-
  Gathers multiple VCF files from a scatter operation into a single VCF file. Input files must be supplied in genomic order and must not have events at overlapping positions.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --INPUT
  doc: Input VCF file(s).
  inputBinding:
    position: 1
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: output
  type: string
  doc: Output VCF file.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: comment
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --COMMENT
  doc: Comment(s) to include in the merged output file's header.
  inputBinding:
    position: 1
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: reorder_input_by_first_variant
  type:
  - 'null'
  - boolean
  doc: 'If ''true'' the program will reorder INPUT according to the genomic location
    of the first variant in each file. this is useful since the order of variants
    in each file in INPUT come from non overlapping regions but the order of the files
    in INPUT is untrusted. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --REORDER_INPUT_BY_FIRST_VARIANT
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_file
  type: File
  doc: Output VCF file.
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
