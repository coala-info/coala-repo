cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidcommunity_plasmidCommunity.sh
label: plasmidcommunity_plasmidCommunity.sh
doc: "A tool for plasmid community analysis. (Note: The provided text appears to be
  a container build error log rather than help text, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/wuxinmiao5/PlasmidCommunity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
stdout: plasmidcommunity_plasmidCommunity.sh.out
