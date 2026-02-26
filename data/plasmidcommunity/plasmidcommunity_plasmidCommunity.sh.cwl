cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidCommunity.sh
label: plasmidcommunity_plasmidCommunity.sh
doc: "Three modes are provided for analysis: silhouetteCurve, getCommunity and pan\n\
  \nTool homepage: https://github.com/wuxinmiao5/PlasmidCommunity"
inputs:
  - id: discutoff
    type:
      - 'null'
      - float
    doc: the distance cutoff to generate community
    inputBinding:
      position: 101
      prefix: --discutoff
  - id: fastani
    type:
      - 'null'
      - string
    doc: the fastani result for input, it's the result saved by silhouetteCurve
    inputBinding:
      position: 101
      prefix: --fastani
  - id: input_membership
    type:
      - 'null'
      - File
    doc: the membership file of the network nodes
    inputBinding:
      position: 101
      prefix: --input_membership
  - id: input_mode
    type: string
    doc: 'the mode chosen for analysis: silhouetteCurve, getCommunity or pan'
    inputBinding:
      position: 101
      prefix: --input_Mode
  - id: input_plasmid_seq
    type:
      - 'null'
      - Directory
    doc: the path of a directory containing plasmids genomes
    inputBinding:
      position: 101
      prefix: --input_plasmid_seq
  - id: membershipcutoff
    type:
      - 'null'
      - int
    doc: the minimum of community size
    inputBinding:
      position: 101
      prefix: --membershipcutoff
  - id: output_tag
    type: string
    doc: the output tag
    inputBinding:
      position: 101
      prefix: --outputtag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
stdout: plasmidcommunity_plasmidCommunity.sh.out
