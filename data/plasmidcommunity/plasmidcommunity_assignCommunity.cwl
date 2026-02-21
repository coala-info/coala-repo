cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidcommunity_assignCommunity
label: plasmidcommunity_assignCommunity
doc: "The provided text does not contain help information for the tool. It contains
  system error logs related to a failed container image build (no space left on device).\n
  \nTool homepage: https://github.com/wuxinmiao5/PlasmidCommunity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
stdout: plasmidcommunity_assignCommunity.out
