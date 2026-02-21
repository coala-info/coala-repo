cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyx
label: pyx
doc: "No description available from the provided log text.\n\nTool homepage: http://pyx.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyx:0.14.1--py35_0
stdout: pyx.out
