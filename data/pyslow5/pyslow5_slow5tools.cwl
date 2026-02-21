cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5tools
label: pyslow5_slow5tools
doc: "The provided text is a container build error log and does not contain help information
  or usage instructions for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/hasindu2008/slow5lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyslow5:1.4.0--py311he8b63cb_0
stdout: pyslow5_slow5tools.out
