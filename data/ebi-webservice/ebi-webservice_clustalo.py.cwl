cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebi-webservice_clustalo.py
label: ebi-webservice_clustalo.py
doc: "A client for the EBI Clustal Omega web service. Note: The provided help text
  contains only system error messages regarding container execution and does not list
  available arguments.\n\nTool homepage: https://github.com/ebi-jdispatcher/webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ebi-webservice:v1.0.0_cv1
stdout: ebi-webservice_clustalo.py.out
