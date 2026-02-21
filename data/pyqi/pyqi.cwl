cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyqi
label: pyqi
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/qir-alliance/pyqir"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyqi:0.3.2--py27_1
stdout: pyqi.out
