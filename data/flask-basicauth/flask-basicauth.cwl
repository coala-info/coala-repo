cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-basicauth
label: flask-basicauth
doc: "A tool for Flask basic access authentication (Note: The provided text contains
  error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/jpvanhal/flask-basicauth"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-basicauth:0.2.0--py36_0
stdout: flask-basicauth.out
