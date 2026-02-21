cwlVersion: v1.2
class: CommandLineTool
baseCommand: julia
label: julia_juliaup
doc: "The Julia programming language is a high-level, high-performance dynamic programming
  language for numerical computing.\n\nTool homepage: https://github.com/JuliaLang/julia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/julia:1.10
stdout: julia_juliaup.out
