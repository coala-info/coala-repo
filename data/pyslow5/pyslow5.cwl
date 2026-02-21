cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyslow5
label: pyslow5
doc: "A Python library for reading and writing SLOW5 files. (Note: The provided text
  contains system error logs rather than tool help text; no arguments could be extracted.)\n
  \nTool homepage: https://github.com/hasindu2008/slow5lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyslow5:1.4.0--py311he8b63cb_0
stdout: pyslow5.out
