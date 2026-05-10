cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-variant-table-to-vcf
label: dsh-bio_variant-table-to-vcf
doc: "Converts an Ensembl variant table to VCF format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_variant_table_path
    type:
      - 'null'
      - File
    doc: input Ensembl variant table path
    inputBinding:
      position: 101
      prefix: --input-variant-table-path
  - id: output_vcf_file_path
    type: string
    doc: Output or path parameter `output_vcf_file_path`
    inputBinding:
      position: 102
      prefix: --output-vcf-file
outputs:
  - id: output_vcf_file
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
