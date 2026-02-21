cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2circos
label: vcf2circos
doc: "A tool for converting VCF (Variant Call Format) files into a format suitable
  for Circos plots.\n\nTool homepage: https://github.com/bioinfo-chru-strasbourg/vcf2circos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2circos:1.2.0--pyhdfd78af_0
stdout: vcf2circos.out
