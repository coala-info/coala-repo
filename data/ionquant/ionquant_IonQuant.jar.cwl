cwlVersion: v1.2
class: CommandLineTool
baseCommand: ionquant
label: ionquant_IonQuant.jar
doc: "IonQuant is a tool for mass spectrometry-based proteomics data analysis. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/Nesvilab/IonQuant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ionquant:1.11.9--py311hdfd78af_0
stdout: ionquant_IonQuant.jar.out
