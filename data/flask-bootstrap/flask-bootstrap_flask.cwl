cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask
label: flask-bootstrap_flask
doc: "Flask command line interface\n\nTool homepage: https://github.com/cookiecutter-flask/cookiecutter-flask"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-bootstrap:3.3.5.7--py36_0
stdout: flask-bootstrap_flask.out
