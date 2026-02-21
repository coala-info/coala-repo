cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasamba
label: rnasamba
doc: "The provided text does not contain help information for rnasamba; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/apcamargo/RNAsamba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasamba:0.2.5--py36h91eb985_1
stdout: rnasamba.out
