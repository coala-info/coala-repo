cwlVersion: v1.2
class: CommandLineTool
baseCommand: metastudent
label: metastudent
doc: "Metastudent is a tool for predicting Gene Ontology (GO) terms from protein sequences.\n
  \nTool homepage: https://github.com/Rostlab/MetaStudent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metastudent:v2.0.1-6-deb_cv1
stdout: metastudent.out
