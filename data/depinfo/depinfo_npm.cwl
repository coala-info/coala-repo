cwlVersion: v1.2
class: CommandLineTool
baseCommand: depinfo
label: depinfo_npm
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/departement-info-cem/depinfo-gabarit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/depinfo:v1.4.0-1-deb-py3_cv1
stdout: depinfo_npm.out
