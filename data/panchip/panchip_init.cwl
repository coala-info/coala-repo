cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panchip
  - init
label: panchip_init
doc: "Initialization of the PanChIP library\n\nTool homepage: https://github.com/hanjunlee21/PanChIP"
inputs:
  - id: library_directory
    type: Directory
    doc: Directory wherein PanChIP library will be stored. > 13.6 GB of storage required.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panchip:3.0.14--py312h7e72e81_0
stdout: panchip_init.out
