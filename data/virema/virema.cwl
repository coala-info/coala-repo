cwlVersion: v1.2
class: CommandLineTool
baseCommand: virema
label: virema
doc: "No description available from the provided text.\n\nTool homepage: https://sourceforge.net/projects/virema/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virema:0.6--py27_0
stdout: virema.out
