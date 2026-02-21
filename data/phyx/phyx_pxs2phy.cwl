cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxs2phy
label: phyx_pxs2phy
doc: "Convert seqfiles from nexus, phylip, or fastq to phylip. Can read from STDIN
  or file.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: seq_file
    type:
      - 'null'
      - File
    doc: input sequence file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: export characters in uppercase
    inputBinding:
      position: 101
      prefix: --uppercase
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: output sequence file, STOUT otherwise
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
