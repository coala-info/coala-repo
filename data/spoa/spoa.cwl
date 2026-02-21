cwlVersion: v1.2
class: CommandLineTool
baseCommand: spoa
label: spoa
doc: "SIMD partial order alignment library\n\nTool homepage: https://github.com/rvaser/spoa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spoa:4.1.5--h077b44d_0
stdout: spoa.out
