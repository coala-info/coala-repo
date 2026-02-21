cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2cytosure
label: vcf2cytosure
doc: "Convert VCF files to CytoSure format for CGH array analysis.\n\nTool homepage:
  https://github.com/NBISweden/vcf2cytosure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2cytosure:0.9.3--pyh7e72e81_0
stdout: vcf2cytosure.out
