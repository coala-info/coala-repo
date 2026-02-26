cwlVersion: v1.2
class: CommandLineTool
baseCommand: python vcf2circos.py
label: vcf2circos
doc: "vcf2circos is a tool to visualize VCF files in a circular genome plot.\n\nTool
  homepage: https://github.com/bioinfo-chru-strasbourg/vcf2circos"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: Genome assembly to use for now values available (hg19, hg38)
    inputBinding:
      position: 101
      prefix: --assembly
  - id: input_file
    type: File
    doc: "Input vcf File\nVCF SHOULD be multiallelic split to avoid trouble in vcf2circos\n\
      example: bcftools -m -any <vcf>\nFormat will be autodetected from file path.\n\
      Supported format:\n   'vcf.gz', 'vcf'"
    inputBinding:
      position: 101
      prefix: --input
  - id: options_file
    type:
      - 'null'
      - File
    doc: Options file in json format
    inputBinding:
      position: 101
      prefix: --options
outputs:
  - id: output_file
    type: File
    doc: "Output file.\nFormat will be autodetected from file path.\nSupported format:\n\
      \   'png', 'jpg', 'jpeg', 'webp', 'svg', 'pdf', 'eps', 'json'"
    outputBinding:
      glob: $(inputs.output_file)
  - id: export_file
    type:
      - 'null'
      - File
    doc: "Export file.\nFormat is 'json'.\nGenerate json file from VCF input file"
    outputBinding:
      glob: $(inputs.export_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2circos:1.2.0--pyhdfd78af_0
