cwlVersion: v1.2
class: CommandLineTool
baseCommand: libgff
label: libgff
doc: "A library and tool for parsing and manipulating GFF (General Feature Format)
  files. Note: The provided help text contains system error messages regarding container
  execution and does not list specific command-line arguments.\n\nTool homepage: https://github.com/COMBINE-lab/libgff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libgff:2.0.0--h077b44d_2
stdout: libgff.out
