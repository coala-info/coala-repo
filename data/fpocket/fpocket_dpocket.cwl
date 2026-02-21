cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpocket
label: fpocket_dpocket
doc: "The provided text does not contain help information for the tool, but rather
  system log errors related to a container runtime failure (no space left on device).
  No arguments could be extracted.\n\nTool homepage: https://github.com/Discngine/fpocket"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocket:4.0.0
stdout: fpocket_dpocket.out
