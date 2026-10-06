cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - AnnotateVcfWithBed
label: biopet_tool_AnnotateVcfWithBed
doc: "Annotate a VCF file with the names of overlapping BED regions as a new INFO field.\n\
  \nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file. Mandatory field
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: bed_file
    type: File
    doc: Input Bed file. Mandatory field
    inputBinding:
      position: 101
      prefix: --bedFile
  - id: output
    type: string
    doc: Output VCF file. Mandatory field
    inputBinding:
      position: 101
      prefix: --output
  - id: field_name
    type: string
    doc: Name of info field in new vcf file
    inputBinding:
      position: 101
      prefix: --fieldName
  - id: field_description
    type:
      - 'null'
      - string
    doc: Description of field in new vcf file
    inputBinding:
      position: 101
      prefix: --fieldDescription
  - id: field_type
    type:
      - 'null'
      - string
    doc: Type of field in new vcf file. Can be 'Integer', 'Flag', 'Character', 'Float'
    inputBinding:
      position: 101
      prefix: --fieldType
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
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
