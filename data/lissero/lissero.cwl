cwlVersion: v1.2
class: CommandLineTool
baseCommand: lissero
label: lissero
doc: "Lissero is a tool for Listeria serogrouping. (Note: The provided text is a system
  error log regarding a container build failure and does not contain the tool's help
  documentation or argument definitions).\n\nTool homepage: https://github.com/MDU-PHL/lissero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lissero:0.4.9--py_0
stdout: lissero.out
