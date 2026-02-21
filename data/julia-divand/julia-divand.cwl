cwlVersion: v1.2
class: CommandLineTool
baseCommand: julia-divand
label: julia-divand
doc: "N-dimensional variational analysis (divand) tool for interpolating observations.\n
  \nTool homepage: https://github.com/gher-uliege/DIVAnd.jl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/julia-divand:2.7.9--h9ee0642_0
stdout: julia-divand.out
