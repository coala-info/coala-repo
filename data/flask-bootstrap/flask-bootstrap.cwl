cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-bootstrap
label: flask-bootstrap
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is a log of a failed execution attempt where the executable
  was not found.\n\nTool homepage: https://github.com/cookiecutter-flask/cookiecutter-flask"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-bootstrap:3.3.5.7--py36_0
stdout: flask-bootstrap.out
