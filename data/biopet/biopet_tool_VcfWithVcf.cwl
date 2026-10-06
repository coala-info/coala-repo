cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - VcfWithVcf
label: biopet_tool_VcfWithVcf
doc: "Annotate a VCF file with INFO fields from a second (indexed) VCF file.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: Input VCF file (indexed)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output_file
    type: string
    doc: Output VCF file
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: secondary_vcf
    type: File
    doc: Indexed VCF file to take fields from
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    inputBinding:
      position: 101
      prefix: --secondaryVcf
  - id: reference
    type: File
    doc: Reference fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --field
    doc: '<field> or <input_field:output_field> or <input_field:output_field:method> (method:
      max, min, unique)'
    inputBinding:
      position: 101
  - id: match
    type:
      - 'null'
      - boolean
    doc: Match alternative alleles; default true
    inputBinding:
      position: 101
      prefix: --match
      valueFrom: '$(self ? "true" : "false")'
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_vcf
    type: File
    doc: Annotated VCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
