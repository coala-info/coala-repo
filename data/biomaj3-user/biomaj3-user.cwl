cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-user
label: biomaj3-user
doc: 'BioMAJ3 user management tool. (Note: The provided text consists of system error
  messages regarding disk space and container conversion rather than command-line
  help documentation; therefore, no arguments could be extracted.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-user:v3.0.6-2-deb-py3_cv1
stdout: biomaj3-user.out
