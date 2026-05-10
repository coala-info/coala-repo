cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-rename-vcf-references
label: dsh-bio_rename-vcf-references
doc: "Rename chromosome reference names in a VCF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: add_chr_prefix
    type:
      - 'null'
      - boolean
    doc: add "chr" to chromosome reference names
    inputBinding:
      position: 101
      prefix: --chr
  - id: input_vcf_path
    type:
      - 'null'
      - File
    doc: input VCF path
    inputBinding:
      position: 101
      prefix: --input-vcf-path
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
