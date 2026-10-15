cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxssort]
label: phyx_pxssort
doc: |-
  Sort sequences by id or length.
  This will take fasta, phylip, and nexus formats from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input sequence file"
    inputBinding:
      prefix: -s
  - id: sortby
    type: ['null', int]
    doc: "what to sort by: 1:id (default) 2:id rev 3:length (<) 4:length (>)"
    inputBinding:
      prefix: -b
  - id: out_file_path
    type: string
    doc: "output sequence file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "sorted sequences"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
