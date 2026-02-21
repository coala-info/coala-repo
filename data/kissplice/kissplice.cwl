cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissplice
label: kissplice
doc: "The provided text is an error message regarding a container runtime failure
  and does not contain the help documentation for the tool.\n\nTool homepage: http://kissplice.prabi.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice.out
