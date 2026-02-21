cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebi-webservice
label: ebi-webservice
doc: "A tool for accessing European Bioinformatics Institute (EBI) web services.\n
  \nTool homepage: https://github.com/ebi-jdispatcher/webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ebi-webservice:v1.0.0_cv1
stdout: ebi-webservice.out
