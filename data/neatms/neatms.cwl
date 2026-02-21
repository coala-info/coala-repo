cwlVersion: v1.2
class: CommandLineTool
baseCommand: neatms
label: neatms
doc: "Neural nEtwork Analysis Tool for Mass Spectrometry (Note: The provided text
  is a container runtime error log and does not contain help information or argument
  definitions).\n\nTool homepage: https://github.com/bihealth/NeatMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neatms:0.7--py_0
stdout: neatms.out
