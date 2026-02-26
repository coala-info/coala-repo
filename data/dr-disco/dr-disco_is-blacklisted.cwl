cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - is-blacklisted
label: dr-disco_is-blacklisted
doc: "When only a single position is given, only matches with blacklisted regions\n\
  from blacklist_regions will be reported.\n\nWhen both POS1 and POS2 are provided,
  also blacklisted junctions between\nPOS1 and POS2 as provided in the blacklist_junctions
  file will be reported.\n\nPositions need to be formated as chr:pos: chr1:1235 or
  chr1:12,345\n\nPositions can be made strand specific by adding them between curly
  brackets:\nchr1:12,345(+) or chr2:12345(-)\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: pos1
    type: string
    doc: First position (chr:pos format)
    inputBinding:
      position: 1
  - id: pos2
    type:
      - 'null'
      - string
    doc: Second position (chr:pos format)
    inputBinding:
      position: 2
  - id: blacklist_junctions
    type:
      - 'null'
      - string
    doc: "Blacklist these region-to-region junctions\n                           \
      \   (custom format, see files in ./share/)"
    inputBinding:
      position: 103
      prefix: --blacklist-junctions
  - id: blacklist_regions
    type:
      - 'null'
      - string
    doc: Blacklist these regions
    inputBinding:
      position: 103
      prefix: --blacklist-regions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
stdout: dr-disco_is-blacklisted.out
