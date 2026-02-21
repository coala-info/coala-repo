cwlVersion: v1.2
class: CommandLineTool
baseCommand: endorspy_endorS.py
label: endorspy_endorS.py
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains system log messages and a fatal error regarding container
  image building.\n\nTool homepage: https://github.com/aidaanva/endorS.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/endorspy:1.4--hdfd78af_0
stdout: endorspy_endorS.py.out
