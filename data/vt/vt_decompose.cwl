cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt decompose
label: vt_decompose
doc: "decomposes multiallelic variants into biallelic in a VCF file.\n\nTool homepage:
  https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    default: ''
    inputBinding:
      position: 102
      prefix: -i
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    default: ''
    inputBinding:
      position: 102
      prefix: -I
  - id: smart_decomposition
    type:
      - 'null'
      - boolean
    doc: smart decomposition
    default: false
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
