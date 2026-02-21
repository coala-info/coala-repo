cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit-msa2vcf
label: jvarkit-msa2vcf
doc: "Multiple Sequence Alignment to VCF\n\nTool homepage: https://lindenb.github.io/jvarkit/MsaToVcf.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-msa2vcf:201904251722--0
stdout: jvarkit-msa2vcf.out
