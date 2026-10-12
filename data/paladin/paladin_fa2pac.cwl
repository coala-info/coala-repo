cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - fa2pac
label: paladin_fa2pac
doc: "Convert a nucleotide FASTA file to PAC format (writes <out.prefix>.pac, .ann
  and .amb)\n\nTool homepage: https://github.com/ToniWestbrook/paladin"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 2
  - id: f_flag
    type:
      - 'null'
      - boolean
    doc: Keep only the forward strand
    inputBinding:
      position: 1
      prefix: -f
  - id: output_prefix
    type: string
    doc: Output prefix for the .pac, .ann and .amb files
    inputBinding:
      position: 3
outputs:
  - id: pac_files
    type:
      type: array
      items: File
    doc: PAC, ANN and AMB files
    outputBinding:
      glob: $(inputs.output_prefix).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
