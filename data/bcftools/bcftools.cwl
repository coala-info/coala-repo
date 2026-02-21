cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcftools
label: bcftools
doc: "BCFtools is a set of utilities that manipulate variant calls in the Variant
  Call Format (VCF) and its binary counterpart BCF.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
stdout: bcftools.out
