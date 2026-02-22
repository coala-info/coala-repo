cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-process
label: biomaj3-process
doc: BioMAJ process management tool
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-process:v3.0.11-1-deb-py3_cv1
stdout: biomaj3-process.out
