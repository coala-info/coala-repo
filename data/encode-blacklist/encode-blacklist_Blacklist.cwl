cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./Blacklist
label: encode-blacklist_Blacklist
doc: "Blacklist is used to generate the ENCODE blacklists for various species.\n\n\
  Tool homepage: https://github.com/Boyle-Lab/Blacklist"
inputs:
  - id: chr
    type: string
    doc: Chromosome
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/encode-blacklist:2.0--h06902ac_6
stdout: encode-blacklist_Blacklist.out
