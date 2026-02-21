cwlVersion: v1.2
class: CommandLineTool
baseCommand: promod3_pm
label: promod3_pm
doc: "The provided text is a container runtime error log and does not contain help
  information or usage instructions for the tool promod3_pm.\n\nTool homepage: https://openstructure.org/promod3/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/promod3:3.6.0--py311he264feb_0
stdout: promod3_pm.out
