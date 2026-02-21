cwlVersion: v1.2
class: CommandLineTool
baseCommand: openms
label: openms
doc: "OpenMS is an open-source software framework for LC-MS data management and analysis.
  (Note: The provided text contains container runtime error messages rather than tool
  help documentation.)\n\nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openms:3.5.0--h78fb946_0
stdout: openms.out
