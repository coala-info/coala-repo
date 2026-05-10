cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt annotate_1000g
label: vt_annotate_1000g
doc: "annotates variants that are present in 1000 Genomes variant set\n\nTool homepage:
  https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: data_set_vcf
    type: File
    doc: 1000G data set VCF file
    inputBinding:
      position: 102
      prefix: -d
  - id: filter_expression
    type:
      - 'null'
      - string
    doc: filter expression
    inputBinding:
      position: 102
      prefix: -f
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
