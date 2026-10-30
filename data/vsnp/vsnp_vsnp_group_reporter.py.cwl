cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_group_reporter.py
label: vsnp_vsnp_group_reporter.py
doc: "Report the defining-SNP groups of a VCF file using the Excel file of a reference option.\n\
  \nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: vcf
    type: File
    doc: 'Required: vcf file'
    inputBinding:
      position: 101
      prefix: -vcf
  - id: ref_option
    type:
      - 'null'
      - string
    doc: 'Required: reference option'
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_group_reporter.py.out
