cwlVersion: v1.2
class: CommandLineTool
baseCommand: galileo
label: galileo
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://github.com/JaredC01/Galileo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galileo:v0.5.1-6-deb_cv1
stdout: galileo.out
