cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfanno
label: vcfanno
doc: "vcfanno: annotate a VCF with other VCFs/BEDs/tabix files\n\nTool homepage: https://github.com/brentp/vcfanno"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfanno:0.3.7--he881be0_0
stdout: vcfanno.out
