cwlVersion: v1.2
class: CommandLineTool
baseCommand: PlasmidTransModel
label: plasmidcommunity_PlasmidTransModel
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build or fetch a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/wuxinmiao5/PlasmidCommunity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
stdout: plasmidcommunity_PlasmidTransModel.out
