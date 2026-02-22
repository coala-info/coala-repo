cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-download
label: biomaj3-download
doc: 'BioMAJ3 download tool (Note: The provided text contains system error messages
  regarding disk space and container conversion rather than command-line help documentation.
  No arguments could be extracted from the input.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-download:v3.0.19-1-deb-py3_cv1
stdout: biomaj3-download.out
