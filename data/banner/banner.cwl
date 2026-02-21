cwlVersion: v1.2
class: CommandLineTool
baseCommand: banner
label: banner
doc: "A tool to display a text banner. (Note: The provided text appears to be a container
  build error log rather than help text; no arguments could be extracted from the
  input.)\n\nTool homepage: https://www.github.com/will-rowe/banner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/banner:0.0.2--py_0
stdout: banner.out
