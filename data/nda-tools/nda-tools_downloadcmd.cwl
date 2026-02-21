cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nda-tools
  - downloadcmd
label: nda-tools_downloadcmd
doc: "NDA Tool for downloading data (Note: The provided text is an error log and does
  not contain help information or argument definitions).\n\nTool homepage: https://github.com/NDAR/nda-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nda-tools:0.6.0--pyh7e72e81_0
stdout: nda-tools_downloadcmd.out
