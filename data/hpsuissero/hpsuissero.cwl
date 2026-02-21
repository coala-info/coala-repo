cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpsuissero
label: hpsuissero
doc: "HPSuissero is a tool for the serotyping of Haemophilus parasuis.\n\nTool homepage:
  https://github.com/jimmyliu1326/HpsuisSero"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpsuissero:1.0.1--hdfd78af_0
stdout: hpsuissero.out
