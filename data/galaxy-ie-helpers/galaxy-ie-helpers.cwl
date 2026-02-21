cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-ie-helpers
label: galaxy-ie-helpers
doc: "A set of helper utilities for Galaxy Interactive Environments. Note: The provided
  input text appears to be a container runtime error log rather than help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/bgruening/galaxy_ie_helpers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
stdout: galaxy-ie-helpers.out
