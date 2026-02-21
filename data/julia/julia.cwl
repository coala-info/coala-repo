cwlVersion: v1.2
class: CommandLineTool
baseCommand: julia
label: julia
doc: "The Julia programming language\n\nTool homepage: https://github.com/JuliaLang/julia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/julia:1.10
stdout: julia.out
