cwlVersion: v1.2
class: CommandLineTool
baseCommand: depinfo
label: depinfo
doc: "A tool to retrieve dependency information for Python packages.\n\nTool homepage:
  https://github.com/departement-info-cem/depinfo-gabarit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/depinfo:v1.4.0-1-deb-py3_cv1
stdout: depinfo.out
