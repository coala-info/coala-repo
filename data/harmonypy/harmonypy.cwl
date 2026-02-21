cwlVersion: v1.2
class: CommandLineTool
baseCommand: harmonypy
label: harmonypy
doc: "Harmony is an algorithm for integrating single-cell datasets.\n\nTool homepage:
  https://github.com/slowkow/harmonypy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harmonypy:0.2.0--pyhdfd78af_0
stdout: harmonypy.out
