cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpp-core
label: bpp-core
doc: "Bio++ Core library. (Note: The provided text contains system error messages
  regarding container execution and disk space, rather than command-line help documentation.)\n\
  \nTool homepage: https://github.com/BioPP/bpp-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpp-core:2.4.1--h470a237_0
stdout: bpp-core.out
