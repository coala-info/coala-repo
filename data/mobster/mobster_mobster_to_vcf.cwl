cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobster-to-vcf
label: mobster_mobster_to_vcf
doc: "Convert a Mobster predictions file into a VCF file.\n\nTool homepage: https://github.com/jyhehir/mobster"
inputs:
  - id: file
    type: File
    doc: 'Mobster predictions file (containing metaheader with # and 1 normal line header)'
    inputBinding:
      position: 1
      prefix: -file
  - id: out
    type: string
    doc: Output vcf file
    inputBinding:
      position: 2
      prefix: -out
outputs:
  - id: output_vcf
    type: File
    doc: Output vcf file
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobster:0.2.4.1--py36_0
