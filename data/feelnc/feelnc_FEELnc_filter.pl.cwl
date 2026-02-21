cwlVersion: v1.2
class: CommandLineTool
baseCommand: feelnc_FEELnc_filter.pl
label: feelnc_FEELnc_filter.pl
doc: "The provided text contains system error messages and container runtime logs
  rather than the tool's help documentation. As a result, no arguments or tool descriptions
  could be extracted.\n\nTool homepage: https://github.com/tderrien/FEELnc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_filter.pl.out
