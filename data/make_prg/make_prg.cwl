cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_prg
label: make_prg
doc: "A tool for creating Population Reference Graphs (PRGs) from a set of aligned
  or unaligned sequences.\n\nTool homepage: https://github.com/rmcolq/make_prg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/make_prg:0.5.0--pyhdfd78af_0
stdout: make_prg.out
