cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-daemon
label: biomaj3-daemon
doc: 'BioMAJ daemon (Note: The provided text contains system error logs regarding
  container execution and disk space rather than tool help documentation. No arguments
  could be extracted.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-daemon:v3.0.17-1-deb-py3_cv1
stdout: biomaj3-daemon.out
