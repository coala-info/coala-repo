cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - gfa2fasta
label: autocycler_gfa2fasta
doc: "convert an Autocycler GFA file to FASTA format\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: in_gfa
    type: File
    doc: Input Autocycler GFA file (required)
    inputBinding:
      position: 101
      prefix: --in_gfa
  - id: out_fasta_path
    type: string
    doc: Output or path parameter `out_fasta_path`
    inputBinding:
      position: 102
      prefix: --out-fasta
outputs:
  - id: out_fasta
    type: File
    doc: Output FASTA file (required)
    outputBinding:
      glob: $(inputs.out_fasta_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
