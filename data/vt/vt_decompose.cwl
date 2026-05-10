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
    inputBinding:
      position: 102
      prefix: -i
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    inputBinding:
      position: 102
      prefix: -I
  - id: smart_decomposition
    type:
      - 'null'
      - boolean
    doc: smart decomposition
    inputBinding:
      position: 102
      prefix: -s
  - id: output_vcf_path
    type: string
    doc: Output or path parameter `output_vcf_path`
    inputBinding:
      position: 103
      prefix: --output-vcf
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
