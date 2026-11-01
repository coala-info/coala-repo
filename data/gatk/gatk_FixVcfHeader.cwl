cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FixVcfHeader
label: gatk_FixVcfHeader
doc: |-
  Replaces or fixes a VCF header.This tool will either replace the header in the input VCF file (INPUT) with the given VCF header (HEADER) or will attempt to fill in any field definitions that are missing in the input header by examining the variants in the input VCF file (INPUT).

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: The input VCF/BCF file.
  inputBinding:
    position: 1
    prefix: --INPUT
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: output
  type: string
  doc: The output VCF/BCF file.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: check_first_n_records
  type:
  - 'null'
  - int
  doc: Check only the first N records when searching for missing INFO and FORMAT fields.
  inputBinding:
    position: 1
    prefix: --CHECK_FIRST_N_RECORDS
- id: enforce_same_samples
  type:
  - 'null'
  - boolean
  doc: 'Enforce that the samples are the same (and in the same order) when replacing
    the VCF header. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --ENFORCE_SAME_SAMPLES
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: header
  type:
  - 'null'
  - File
  doc: The replacement VCF header.
  inputBinding:
    position: 1
    prefix: --HEADER
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
outputs:
- id: output_file
  type: File
  doc: The output VCF/BCF file.
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
