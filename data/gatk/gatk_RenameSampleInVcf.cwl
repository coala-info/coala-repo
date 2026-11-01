cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- RenameSampleInVcf
label: gatk_RenameSampleInVcf
doc: |-
  This tool enables the user to rename a sample in either a VCF or BCF file. It is intended to change the name of a sample in a VCF prior to merging with VCF files in which one or more samples have similar names. Note that the input VCF file must be single-sample VCF and that the NEW_SAMPLE_NAME is required.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: Input single sample VCF or BCF file.
  inputBinding:
    position: 1
    prefix: --INPUT
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: new_sample_name
  type: string
  doc: New name to give sample in output VCF.
  inputBinding:
    position: 1
    prefix: --NEW_SAMPLE_NAME
- id: output
  type: string
  doc: Output single sample VCF.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: old_sample_name
  type:
  - 'null'
  - string
  doc: Existing name of sample in VCF; if provided, asserts that that is the name
    of the extant sample name
  inputBinding:
    position: 1
    prefix: --OLD_SAMPLE_NAME
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
  doc: Output single sample VCF.
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
