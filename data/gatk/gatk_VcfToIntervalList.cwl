cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- VcfToIntervalList
label: gatk_VcfToIntervalList
doc: |-
  This tool creates a Picard Interval List from a VCF or BCF. It is important that the file extension is included as the file format is determined by the fileextension. Variants that were filtered can be included in the output interval list by settingINCLUDE_FILTERED to true. Usage example: java -jar picard.jar VcfToIntervalList I=sample.vcf O=sample.interval_list

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: The BCF or VCF input file. The file format is determined by file extension.
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
  doc: The output Picard Interval List.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: include_filtered
  type:
  - 'null'
  - boolean
  doc: 'Include variants that were filtered in the output interval list. Possible
    values: true, false.'
  inputBinding:
    position: 1
    prefix: --INCLUDE_FILTERED
    valueFrom: '$(self ? ''true'' : ''false'')'
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
- id: variant_id_method
  type:
  - 'null'
  - string
  doc: 'Controls the naming of the resulting intervals. When set to CONCAT_ALL (the
    default), each resulting interval will be named the concatenation of the variant
    ID fields (if present), or ''interval-<number>'' (if not) with a pipe ''|'' separator.
    If set to USE_FIRST, only the first name will be used. Possible values: CONCAT_ALL,
    USE_FIRST.'
  inputBinding:
    position: 1
    prefix: --VARIANT_ID_METHOD
outputs:
- id: output_file
  type: File
  doc: The output Picard Interval List.
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
