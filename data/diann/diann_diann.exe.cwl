cwlVersion: v1.2
class: CommandLineTool
baseCommand: diann
label: diann_diann.exe
doc: "DIA-NN: universal software for data-independent acquisition (DIA) proteomics
  data processing. (Note: The provided text contains system error messages regarding
  container execution and does not list command-line arguments.)\n\nTool homepage:
  https://github.com/vdemichev/DiaNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/diann:v1.8.1_cv1
stdout: diann_diann.exe.out
