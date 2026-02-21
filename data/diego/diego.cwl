cwlVersion: v1.2
class: CommandLineTool
baseCommand: diego
label: diego
doc: "The provided text does not contain help information or usage instructions for
  the tool 'diego'. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/DIEGO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diego:0.1.2--py_0
stdout: diego.out
