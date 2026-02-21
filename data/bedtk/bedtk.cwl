cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedtk
label: bedtk
doc: "The provided text does not contain help information for bedtk; it contains system
  logs and error messages related to a failed container build process.\n\nTool homepage:
  https://github.com/lh3/bedtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
stdout: bedtk.out
