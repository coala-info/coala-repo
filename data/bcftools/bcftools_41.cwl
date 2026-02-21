cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - '41'
label: bcftools_41
doc: "BCFtools (Note: The provided help text indicates an unrecognized command error
  for '41')\n\nTool homepage: https://github.com/samtools/bcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
stdout: bcftools_41.out
