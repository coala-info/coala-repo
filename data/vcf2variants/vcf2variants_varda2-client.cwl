cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2variants
label: vcf2variants_varda2-client
doc: "A tool for converting VCF files to a variant format, typically used with the
  Varda2 system. (Note: The provided text appears to be a container engine error log
  rather than the tool's help output, so no arguments could be extracted.)\n\nTool
  homepage: https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2variants:1.3--pyhdfd78af_0
stdout: vcf2variants_varda2-client.out
