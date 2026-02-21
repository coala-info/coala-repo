cwlVersion: v1.2
class: CommandLineTool
baseCommand: fwdpp
label: fwdpp
doc: "fwdpp is a C++ template library for forward-time population genetic simulations.\n
  \nTool homepage: https://www.github.com/molpopgen/fwdpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fwdpp:0.9.2--ha172671_0
stdout: fwdpp.out
