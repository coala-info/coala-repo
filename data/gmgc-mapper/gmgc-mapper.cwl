cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmgc-mapper
label: gmgc-mapper
doc: "GMGC-mapper\n\nTool homepage: https://github.com/BigDataBiology/GMGC-mapper"
inputs:
  - id: aa_input
    type:
      - 'null'
      - File
    doc: Path to the input amino acid gene file (FASTA format)
    inputBinding:
      position: 101
      prefix: --aa-genes
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: Path to the input genome FASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: nt_input
    type:
      - 'null'
      - File
    doc: Path to the input DNA gene file (FASTA format)
    inputBinding:
      position: 101
      prefix: --nt-genes
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory (will be created if non-existent)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmgc-mapper:0.2.0--pyh864c0ab_1
