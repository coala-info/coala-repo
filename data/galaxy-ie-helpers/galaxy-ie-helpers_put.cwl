cwlVersion: v1.2
class: CommandLineTool
baseCommand: put
label: galaxy-ie-helpers_put
doc: "A helper utility for Galaxy Interactive Environments to upload/save files back
  to the Galaxy history.\n\nTool homepage: https://github.com/bgruening/galaxy_ie_helpers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
stdout: galaxy-ie-helpers_put.out
