cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - VepNormalizer
label: biopet_tool_VepNormalizer
doc: "Parse a VEP-annotated VCF to standard VCF format.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file. Required.
    inputBinding:
      position: 101
      prefix: --InputFile
  - id: output_file
    type: string
    doc: Output VCF file. Required.
    inputBinding:
      position: 101
      prefix: --OutputFile
  - id: mode
    type: string
    doc: Mode. Can choose between <standard> (generates standard vcf) and <explode> (generates
      new record for each transcript). Required.
    inputBinding:
      position: 101
      prefix: --mode
  - id: do_not_remove
    type:
      - 'null'
      - boolean
    doc: Do not remove CSQ tag. Optional
    inputBinding:
      position: 101
      prefix: --do-not-remove
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
    doc: Normalized VCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
