cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- VcfFormatConverter
label: gatk_VcfFormatConverter
doc: |-
  Converts VCF to BCF or BCF to VCF. This tool converts files between the plain-text VCF format and its binary compressed equivalent, BCF. Input and output formats are determined by file extensions specified in the file names. For best results, it is recommended to ensure that an index file is present and set the REQUIRE_INDEX option to true. Usage example: java -jar picard.jar VcfFormatConverter \ I=input.vcf \ O=output.bcf \ REQUIRE_INDEX=true

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type: File
  doc: The BCF or VCF input file.
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
  doc: The BCF or VCF output file name.
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
- id: require_index
  type:
  - 'null'
  - boolean
  doc: 'Fail if an index is not available for the input VCF/BCF Possible values: true,
    false.'
  inputBinding:
    position: 1
    prefix: --REQUIRE_INDEX
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_file
  type: File
  doc: The BCF or VCF output file name.
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
