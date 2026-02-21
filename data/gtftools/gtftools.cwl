cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtftools
label: gtftools
doc: "A tool for processing GTF files (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/RacconC/gtftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtftools:0.9.0--pyh5e36f6f_0
stdout: gtftools.out
