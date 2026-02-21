cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfm-id
label: cfm_cfm-id
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log indicating a 'no space left on device' failure
  during image extraction.\n\nTool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
stdout: cfm_cfm-id.out
