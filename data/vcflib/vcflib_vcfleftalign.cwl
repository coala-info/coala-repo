cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfleftalign
label: vcflib_vcfleftalign
doc: "Left-align variants in a VCF file.\n\nTool homepage: https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfleftalign.out
