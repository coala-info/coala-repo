cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam2
  - index
label: leviosam2_index
doc: "Build a levioSAM2 index of a chain file.\n\nTool homepage: https://github.com/milkschen/leviosam2"
inputs:
  - id: chain
    type: File
    doc: 'Path to the chain file to index.'
    inputBinding:
      position: 1
      prefix: -c
  - id: dest_fai
    type: File
    doc: 'Path to the FAI (FASTA index) file of the target reference.'
    inputBinding:
      position: 2
      prefix: -F
  - id: prefix
    type: string
    doc: 'Prefix of the output file.'
    inputBinding:
      position: 3
      prefix: -p
outputs:
  - id: index_file
    type: File
    doc: 'The ChainMap index (.clft)'
    outputBinding:
      glob: $(inputs.prefix).clft
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
