cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequali
label: sequali
doc: "A tool for sequence quality control (Note: The provided text is a container
  build error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/rhpvorderman/sequali"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequali:1.0.2--py310h1fe012e_0
stdout: sequali.out
