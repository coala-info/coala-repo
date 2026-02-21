cwlVersion: v1.2
class: CommandLineTool
baseCommand: prince
label: prince
doc: "Predicting Protein Complexes using Co-elution (PRiNCE)\n\nTool homepage: https://github.com/WGS-TB/PythonPrince"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prince:2.3--py_0
stdout: prince.out
