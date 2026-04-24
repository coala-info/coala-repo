cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-vcf-pedigree
label: dsh-bio_vcf-pedigree
doc: "Generates a pedigree file from a VCF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
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
  - id: output_pedigree_file
    type:
      - 'null'
      - File
    doc: output pedigree file
    outputBinding:
      glob: $(inputs.output_pedigree_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
