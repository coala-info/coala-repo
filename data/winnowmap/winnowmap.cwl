cwlVersion: v1.2
class: CommandLineTool
baseCommand: winnowmap
label: winnowmap
doc: "Winnowmap is a long-read alignment tool. (Note: The provided text contains container
  build errors rather than the tool's help documentation.)\n\nTool homepage: https://github.com/marbl/Winnowmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/winnowmap:2.03--h5ca1c30_4
stdout: winnowmap.out
