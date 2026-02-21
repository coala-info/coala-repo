cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - get
label: galaxy-ie-helpers_get
doc: "A helper tool for Galaxy Interactive Environments to retrieve data. Note: The
  provided help text contains only system error logs and does not list specific arguments.\n
  \nTool homepage: https://github.com/bgruening/galaxy_ie_helpers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
stdout: galaxy-ie-helpers_get.out
