cwlVersion: v1.2
class: CommandLineTool
baseCommand: mumemto
label: mumemto
doc: "A tool for analyzing DNA methylation (Note: The provided text is a container
  execution error log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/vikshiv/mumemto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
stdout: mumemto.out
