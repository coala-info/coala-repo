cwlVersion: v1.2
class: CommandLineTool
baseCommand: sage
label: hmftools-sage
doc: "Somatic Actionable Genomic Editing (SAGE) variant caller. Note: The provided
  text contains system error messages regarding container execution and does not list
  command-line arguments.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/sage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-sage:4.2--hdfd78af_0
stdout: hmftools-sage.out
