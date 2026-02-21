cwlVersion: v1.2
class: CommandLineTool
baseCommand: lukasa_lukasa.py
label: lukasa_lukasa.py
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding disk space during a
  container build.\n\nTool homepage: https://github.com/pvanheus/lukasa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lukasa:0.15.0--py310hdfd78af_0
stdout: lukasa_lukasa.py.out
