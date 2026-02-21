cwlVersion: v1.2
class: CommandLineTool
baseCommand: requests-toolbelt
label: requests-toolbelt
doc: "The provided text does not contain help documentation or usage instructions
  for requests-toolbelt. It appears to be a log of a failed container build process.\n
  \nTool homepage: https://github.com/requests/toolbelt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/requests-toolbelt:0.5.0--py35_0
stdout: requests-toolbelt.out
