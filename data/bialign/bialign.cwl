cwlVersion: v1.2
class: CommandLineTool
baseCommand: bialign
label: bialign
doc: "No description available: The provided text contains container build logs and
  error messages rather than tool help text.\n\nTool homepage: https://github.com/s-will/BiAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bialign:0.3--py310hec16e2b_0
stdout: bialign.out
