cwlVersion: v1.2
class: CommandLineTool
baseCommand: genera
label: genera
doc: "The provided text does not contain help information or usage instructions for
  the tool 'genera'. It contains system log messages and a fatal error regarding disk
  space during a container image conversion.\n\nTool homepage: https://github.com/josuebarrera/GenEra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
stdout: genera.out
