cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpehhbin
label: hapbin_xpehhbin
doc: "The provided text does not contain help information or usage instructions; it
  contains system error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/evotools/hapbin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
stdout: hapbin_xpehhbin.out
