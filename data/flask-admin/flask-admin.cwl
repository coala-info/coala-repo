cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-admin
label: flask-admin
doc: "Flask-Admin command line interface (Note: The provided text contains error logs
  indicating the executable was not found, rather than standard help documentation).\n
  \nTool homepage: https://github.com/pallets-eco/flask-admin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-admin:1.4.0--py36_0
stdout: flask-admin.out
