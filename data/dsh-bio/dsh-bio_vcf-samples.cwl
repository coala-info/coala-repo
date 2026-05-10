cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-vcf-samples
label: dsh-bio_vcf-samples
doc: "Extracts sample names from a VCF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_vcf_path
    type:
      - 'null'
      - File
    doc: input VCF path
    inputBinding:
      position: 101
      prefix: --input-vcf-path
  - id: output_sample_file_path
    type: string
    doc: Output or path parameter `output_sample_file_path`
    inputBinding:
      position: 102
      prefix: --output-sample-file
outputs:
  - id: output_sample_file
    type:
      - 'null'
      - File
    doc: output sample file
    outputBinding:
      glob: $(inputs.output_sample_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
