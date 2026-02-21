cwlVersion: v1.2
class: CommandLineTool
baseCommand: mira
label: mira
doc: "MIRA is a multi-purpose assembly system for whole genome sequencing (Note: The
  provided text contains container runtime errors and does not include the actual
  help documentation for the tool).\n\nTool homepage: https://github.com/DrMicrobit/mira"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mira:5.0.0rc2--hb5a7bbe_0
stdout: mira.out
