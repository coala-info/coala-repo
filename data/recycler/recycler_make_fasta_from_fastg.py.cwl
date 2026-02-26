cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycler_make_fasta_from_fastg.py
label: recycler_make_fasta_from_fastg.py
doc: "make_fasta_from_fastg converts fastg assembly graph to fasta format\n\nTool
  homepage: https://github.com/Shamir-Lab/Recycler"
inputs:
  - id: graph
    type: File
    doc: '(spades 3.50+) FASTG file to process [recommended: before_rr.fastg]'
    inputBinding:
      position: 101
      prefix: --graph
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name for FASTA of cycles
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
