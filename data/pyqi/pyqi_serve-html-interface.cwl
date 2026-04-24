cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyqi serve-html-interface
label: pyqi_serve-html-interface
doc: "Start the HTMLInterface server and load the provided interface_module and port\n\
  \nTool homepage: https://github.com/qir-alliance/pyqir"
inputs:
  - id: interface_module
    type: string
    doc: The module to serve the interface for
    inputBinding:
      position: 101
      prefix: --interface-module
  - id: port
    type:
      - 'null'
      - int
    doc: The port to run the server on
    inputBinding:
      position: 101
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyqi:0.3.2--py27_1
stdout: pyqi_serve-html-interface.out
