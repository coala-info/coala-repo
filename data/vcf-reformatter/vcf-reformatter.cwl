cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-reformatter
label: vcf-reformatter
doc: "A tool for reformatting VCF (Variant Call Format) files. Note: The provided
  text contains container build logs and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/flalom/vcf-reformatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-reformatter:0.3.0--h4349ce8_0
stdout: vcf-reformatter.out
