cwlVersion: v1.2
class: CommandLineTool
baseCommand: diann
label: diann
doc: "DIA-NN (Data-Independent Acquisition by Neural Networks) is a software tool
  for the analysis of DIA proteomics data. Note: The provided input text contains
  system error messages and does not include help documentation or argument definitions.\n
  \nTool homepage: https://github.com/vdemichev/DiaNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/diann:v1.8.1_cv1
stdout: diann.out
