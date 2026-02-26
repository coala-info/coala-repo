cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2variants
label: vcf2variants
doc: "Read phase sets from single sample VCF 4.3 file.\n\nTool homepage: https://github.com/varda/varda2_preprocessing"
inputs:
  - id: filename
    type: File
    doc: VCF file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2variants:1.3--pyhdfd78af_0
stdout: vcf2variants.out
