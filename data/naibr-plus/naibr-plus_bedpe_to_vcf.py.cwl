cwlVersion: v1.2
class: CommandLineTool
baseCommand: naibr-plus_bedpe_to_vcf.py
label: naibr-plus_bedpe_to_vcf.py
doc: "A script to convert BEDPE files to VCF format (Note: The provided help text
  contains only system error messages and no argument definitions).\n\nTool homepage:
  https://github.com/pontushojer/NAIBR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
stdout: naibr-plus_bedpe_to_vcf.py.out
