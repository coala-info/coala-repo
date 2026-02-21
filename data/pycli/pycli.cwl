cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycli
label: pycli
doc: "The provided text does not contain help information or usage instructions for
  the tool; it appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/markovi/PyClick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycli:2.0.3--py35_0
stdout: pycli.out
