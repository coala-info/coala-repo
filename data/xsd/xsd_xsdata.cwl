cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsd
label: xsd_xsdata
doc: "The provided text contains system logs and error messages related to a container
  build process rather than the command-line help documentation for the tool. As a
  result, no arguments or specific tool descriptions could be extracted from the input.\n
  \nTool homepage: https://github.com/tefra/xsdata"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsd:4.0.0_dep--h7208437_6
stdout: xsd_xsdata.out
