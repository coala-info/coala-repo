cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2variants
label: vcf2variants
doc: "A tool to convert VCF files to variants. (Note: The provided text contains system
  logs and error messages rather than help documentation; no arguments could be extracted.)\n
  \nTool homepage: https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2variants:1.3--pyhdfd78af_0
stdout: vcf2variants.out
