cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-nav
label: flask-nav
doc: "A Flask extension for handling navigation bars.\n\nTool homepage: https://github.com/cirosantilli/china-dictatorship"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-nav:0.5--py36_0
stdout: flask-nav.out
