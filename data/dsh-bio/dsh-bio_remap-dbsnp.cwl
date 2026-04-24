cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-remap-dbsnp
label: dsh-bio_remap-dbsnp
doc: "Remaps dbSNP IDs in a VCF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_vcf_path
    type:
      - 'null'
      - File
    doc: input VCF path
    inputBinding:
      position: 101
      prefix: --input-vcf-path
outputs:
  - id: output_vcf_file
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
