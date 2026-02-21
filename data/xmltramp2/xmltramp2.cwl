cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmltramp2
label: xmltramp2
doc: "The provided text does not contain help information or usage instructions for
  xmltramp2; it appears to be an error log from a container build process.\n\nTool
  homepage: https://github.com/tBaxter/xmltramp2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmltramp2:3.1.1--py35_0
stdout: xmltramp2.out
