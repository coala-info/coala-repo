cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-core
label: biomaj3-core
doc: 'BioMAJ (Biological Management of Algorithms and Jars) is a workflow engine dedicated
  to data bank management. (Note: The provided text contained only system error logs
  and no help documentation to parse arguments from).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-core:v3.0.15-1-deb-py3_cv1
stdout: biomaj3-core.out
