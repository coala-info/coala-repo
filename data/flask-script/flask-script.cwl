cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-script
label: flask-script
doc: "Flask-Script is an extension that provides support for writing external scripts
  in Flask.\n\nTool homepage: https://github.com/smurfix/flask-script"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-script:2.0.5--py35_0
stdout: flask-script.out
