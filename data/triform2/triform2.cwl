cwlVersion: v1.2
class: CommandLineTool
baseCommand: triform2
label: triform2
doc: "Triform2 is a tool for peak-calling in ChIP-seq data. (Note: The provided text
  contains container build error logs rather than the tool's help documentation.)\n
  \nTool homepage: https://github.com/endrebak/triform"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/triform2:0.0.5--py27r3.2.2_0
stdout: triform2.out
