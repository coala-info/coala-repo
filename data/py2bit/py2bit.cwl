cwlVersion: v1.2
class: CommandLineTool
baseCommand: py2bit
label: py2bit
doc: "The provided text is a container build error log and does not contain the help
  documentation or usage instructions for the py2bit tool.\n\nTool homepage: https://github.com/deeptools/py2bit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/py2bit:0.3.3--py311haab0aaa_1
stdout: py2bit.out
