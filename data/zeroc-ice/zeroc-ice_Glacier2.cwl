cwlVersion: v1.2
class: CommandLineTool
baseCommand: glacier2router
label: zeroc-ice_Glacier2
doc: "The provided text does not contain help information for the tool; it contains
  container build logs and error messages related to fetching an OCI image.\n\nTool
  homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_Glacier2.out
