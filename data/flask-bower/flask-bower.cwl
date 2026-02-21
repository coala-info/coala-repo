cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-bower
label: flask-bower
doc: "A Flask extension to manage Bower dependencies.\n\nTool homepage: http://github.com/lobeck/flask-bower"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-bower:1.3.0--py36_0
stdout: flask-bower.out
