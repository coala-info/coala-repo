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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name for FASTA of cycles
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
