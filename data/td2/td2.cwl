cwlVersion: v1.2
class: CommandLineTool
baseCommand: td2
label: td2
doc: "The provided text contains error messages related to a container runtime failure
  (no space left on device) and does not contain help documentation or usage instructions
  for the tool 'td2'.\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2.out
