cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fasta-to-pangenome-tree
label: dsh-bio_fasta-to-pangenome-tree
doc: "Converts FASTA files to a pangenome tree.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_fasta_path
    type:
      - 'null'
      - File
    doc: input FASTA path
    inputBinding:
      position: 101
      prefix: --input-fasta-path
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
