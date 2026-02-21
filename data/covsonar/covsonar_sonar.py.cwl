cwlVersion: v1.2
class: CommandLineTool
baseCommand: covsonar_sonar.py
label: covsonar_sonar.py
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error indicating a failure to build a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/rki-mf1/covsonar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/covsonar:2.0.0a1--pyhdfd78af_0
stdout: covsonar_sonar.py.out
