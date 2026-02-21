cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg
label: hicberg
doc: "A tool for Hi-C data analysis (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
stdout: hicberg.out
