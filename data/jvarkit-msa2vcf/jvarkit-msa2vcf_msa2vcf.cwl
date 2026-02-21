cwlVersion: v1.2
class: CommandLineTool
baseCommand: msa2vcf
label: jvarkit-msa2vcf_msa2vcf
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device). As a result, no arguments could be extracted.\n\nTool homepage:
  https://lindenb.github.io/jvarkit/MsaToVcf.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-msa2vcf:201904251722--0
stdout: jvarkit-msa2vcf_msa2vcf.out
