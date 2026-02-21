cwlVersion: v1.2
class: CommandLineTool
baseCommand: cath-tools
label: cath-tools
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a system log showing a fatal error during a container build process
  (no space left on device).\n\nTool homepage: https://github.com/UCLOrengoGroup/cath-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
stdout: cath-tools.out
