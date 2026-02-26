cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - clean
label: agtools_clean
doc: "Clean a GFA file based on segments in a FASTA file\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: assembler name (if assembler used is myloasm)
    inputBinding:
      position: 101
      prefix: --assembler
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to the FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: graph
    type:
      type: array
      items: File
    doc: path(s) to the assembly graph file(s)
    inputBinding:
      position: 101
      prefix: --graph
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
