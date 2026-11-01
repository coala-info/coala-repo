cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SortVcf
label: gatk_SortVcf
doc: |-
  Sorts one or more VCF files. This tool sorts the records in VCF files according to the order of the contigs in the header/sequence dictionary and then by coordinate. It can accept an external sequence dictionary. If no external dictionary is supplied, the VCF file headers of multiple inputs must have the same sequence dictionaries. If running on multiple inputs (originating from e.g.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --INPUT
  doc: Input VCF(s) to be sorted. Multiple inputs must have the same sample names
    (in order)
  inputBinding:
    position: 1
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: output
  type: string
  doc: Output VCF to be written.
  inputBinding:
    position: 1
    prefix: --OUTPUT
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
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Undocumented option
  inputBinding:
    position: 1
    prefix: --SEQUENCE_DICTIONARY
outputs:
- id: output_file
  type: File
  doc: Output VCF to be written.
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
