cwlVersion: v1.2
class: CommandLineTool
baseCommand: igor
label: igor
doc: "Inference and Generation Of Repertoires (Note: The provided text contains container
  runtime error messages rather than tool help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/igor-petruk/scriptisto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/igor:v1.3.0dfsg-1-deb_cv1
stdout: igor.out
