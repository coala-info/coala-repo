cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-vcf
label: dsh-bio_compress-vcf
doc: "Compresses a VCF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_vcf_path
    type:
      - 'null'
      - File
    doc: input VCF path, default stdin
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-vcf-path
outputs:
  - id: output_vcf_file
    type:
      - 'null'
      - File
    doc: output VCF file, default stdout
    outputBinding:
      glob: $(inputs.output_vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
