cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracknado
label: tracknado
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or argument definitions for the tool.\n\nTool homepage:
  https://pypi.org/project/tracknado/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
stdout: tracknado.out
