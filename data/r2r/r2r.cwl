cwlVersion: v1.2
class: CommandLineTool
baseCommand: r2r
label: r2r
doc: "A tool for drawing RNA secondary structures. (Note: The provided help text contains
  container execution errors and does not list command-line arguments.)\n\nTool homepage:
  http://breaker.research.yale.edu/R2R/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/r2r:1.0.6--pl5321h503566f_5
stdout: r2r.out
