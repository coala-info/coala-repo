cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebi-webservice_ncbiblast.py
label: ebi-webservice_ncbiblast.py
doc: "EBI NCBI BLAST web service client. (Note: The provided text contains system
  error logs regarding container execution and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/ebi-jdispatcher/webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ebi-webservice:v1.0.0_cv1
stdout: ebi-webservice_ncbiblast.py.out
