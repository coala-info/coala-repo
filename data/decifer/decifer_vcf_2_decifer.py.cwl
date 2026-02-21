cwlVersion: v1.2
class: CommandLineTool
baseCommand: decifer_vcf_2_decifer.py
label: decifer_vcf_2_decifer.py
doc: "A tool to convert VCF files to Decifer input format. Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/raphael-group/decifer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decifer:2.1.4--py312hf731ba3_4
stdout: decifer_vcf_2_decifer.py.out
