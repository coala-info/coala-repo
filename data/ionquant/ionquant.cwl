cwlVersion: v1.2
class: CommandLineTool
baseCommand: ionquant
label: ionquant
doc: "IonQuant: A comprehensive and ultra-fast tool for MS1-based quantification.\n
  \nTool homepage: https://github.com/Nesvilab/IonQuant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ionquant:1.11.9--py311hdfd78af_0
stdout: ionquant.out
