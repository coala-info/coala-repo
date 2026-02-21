cwlVersion: v1.2
class: CommandLineTool
baseCommand: adun.app
label: adun.app
doc: "Molecular simulator (Note: The provided text is an error log from a container
  build process and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/bidemiadedokun07/AdunniApp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/adun.app:v0.81-13-deb_cv1
stdout: adun.app.out
