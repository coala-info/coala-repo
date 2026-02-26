cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsignal_plant
label: deepsignal-plant_deepsignal_plant
doc: "deepsignal_plant detects base modifications from Nanopore reads of plants, which
  contains five modules:\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
inputs:
  - id: module
    type: string
    doc: deepsignal_plant modules, use -h/--help for help
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
stdout: deepsignal-plant_deepsignal_plant.out
