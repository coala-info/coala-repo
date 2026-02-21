cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2variants
label: vcf2variants_cthreepo
doc: "A tool for converting VCF files to variants. (Note: The provided text is a container
  build error log and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2variants:1.3--pyhdfd78af_0
stdout: vcf2variants_cthreepo.out
