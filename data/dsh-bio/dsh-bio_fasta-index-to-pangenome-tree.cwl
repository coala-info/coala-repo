cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fasta-index-to-pangenome-tree
label: dsh-bio_fasta-index-to-pangenome-tree
doc: "Converts a FASTA index to a pangenome tree.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta_index_path
    type:
      - 'null'
      - File
    doc: input FASTA index (.fai) path
    inputBinding:
      position: 101
      prefix: --input-fasta-index-path
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort pangenome samples, haplotypes, and scaffolds before writing
    inputBinding:
      position: 101
      prefix: --sort
  - id: output_pangenome_file_path
    type: string
    doc: Output or path parameter `output_pangenome_file_path`
    inputBinding:
      position: 102
      prefix: --output-pangenome-file
outputs:
  - id: output_pangenome_file
    type:
      - 'null'
      - File
    doc: output pangenome tree file
    outputBinding:
      glob: $(inputs.output_pangenome_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
