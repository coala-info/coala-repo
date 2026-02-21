cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2variants
  - gvcf2coverage
label: vcf2variants_gvcf2coverage
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process.\n\nTool homepage:
  https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2variants:1.3--pyhdfd78af_0
stdout: vcf2variants_gvcf2coverage.out
