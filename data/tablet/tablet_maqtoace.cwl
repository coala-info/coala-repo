cwlVersion: v1.2
class: CommandLineTool
baseCommand: tablet_maqtoace
label: tablet_maqtoace
doc: "A tool for converting MAQ map files to ACE format for use with the Tablet assembly
  viewer.\n\nTool homepage: https://ics.hutton.ac.uk/tablet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tablet:1.17.08.17--0
stdout: tablet_maqtoace.out
