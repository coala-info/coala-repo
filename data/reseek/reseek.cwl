cwlVersion: v1.2
class: CommandLineTool
baseCommand: reseek
label: reseek
doc: "The provided text is a container build log and does not contain the tool's help
  documentation or argument definitions.\n\nTool homepage: https://github.com/rcedgar/reseek"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseek:2.6.1--h503566f_0
stdout: reseek.out
