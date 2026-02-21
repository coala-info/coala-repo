cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddi-web-app
label: ddi-web-app
doc: "A web application tool (Note: The provided text contains container runtime error
  logs rather than tool help text, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/tzun4mi/android-hack-pack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ddi-web-app:latest
stdout: ddi-web-app.out
