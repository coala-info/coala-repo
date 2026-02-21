cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv-vcf2json
label: cnv-vcf2json
doc: "A tool to convert CNV (Copy Number Variation) VCF files to JSON format.\n\n
  Tool homepage: https://github.com/conda-forge/cnv-vcf2json-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnv-vcf2json:2.0.0
stdout: cnv-vcf2json.out
