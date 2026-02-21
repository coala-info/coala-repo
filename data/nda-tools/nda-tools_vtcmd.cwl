cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtcmd
label: nda-tools_vtcmd
doc: "NDA Validation Tool (Note: The provided text is a system error log and does
  not contain help documentation or argument definitions).\n\nTool homepage: https://github.com/NDAR/nda-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nda-tools:0.6.0--pyh7e72e81_0
stdout: nda-tools_vtcmd.out
