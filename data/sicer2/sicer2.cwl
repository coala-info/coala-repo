cwlVersion: v1.2
class: CommandLineTool
baseCommand: sicer2
label: sicer2
doc: "The provided text does not contain help information for sicer2; it contains
  container runtime error logs. No arguments could be extracted.\n\nTool homepage:
  https://pypi.org/project/SICER2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sicer2:2.1.0--py310h1f9203e_0
stdout: sicer2.out
