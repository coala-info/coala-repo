cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-hgvstovcf
label: ucsc-hgvstovcf
doc: "A tool to convert HGVS (Human Genome Variation Society) notations to VCF (Variant
  Call Format). Note: The provided help text contains only container runtime logs
  and a fatal error, so no specific arguments could be extracted.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgvstovcf:377--h199ee4e_0
stdout: ucsc-hgvstovcf.out
