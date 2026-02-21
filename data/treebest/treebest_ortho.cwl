cwlVersion: v1.2
class: CommandLineTool
baseCommand: treebest_ortho
label: treebest_ortho
doc: "TreeBest orthology analysis (Note: The tool failed to provide a standard help
  menu and instead attempted to open '--help' as a file, suggesting it may primarily
  accept file paths as positional arguments).\n\nTool homepage: https://github.com/lh3/treebest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_ortho.out
