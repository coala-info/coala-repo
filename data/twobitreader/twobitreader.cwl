cwlVersion: v1.2
class: CommandLineTool
baseCommand: twobitreader
label: twobitreader
doc: "A Python module and command-line tool for reading .2bit files, commonly used
  for genome sequences.\n\nTool homepage: https://github.com/benjschiller/twobitreader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twobitreader:3.1.7--py_0
stdout: twobitreader.out
