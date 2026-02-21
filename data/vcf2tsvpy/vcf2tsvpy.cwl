cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2tsvpy
label: vcf2tsvpy
doc: "A tool for converting VCF (Variant Call Format) files to TSV (Tab-Separated
  Values) format.\n\nTool homepage: https://github.com/sigven/vcf2tsvpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2tsvpy:0.6.1--pyhda70652_0
stdout: vcf2tsvpy.out
