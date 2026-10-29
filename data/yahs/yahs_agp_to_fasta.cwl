cwlVersion: v1.2
class: CommandLineTool
baseCommand: agp_to_fasta
label: yahs_agp_to_fasta
doc: "Build a scaffold FASTA file from an AGP file and the contig FASTA file\n\nTool
  homepage: https://github.com/c-zhou/yahs"
inputs:
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width [60]
    inputBinding:
      position: 1
      prefix: -l
  - id: allow_unknown_orientation
    type:
      - 'null'
      - boolean
    doc: allow sequence components with unknown orientations
    inputBinding:
      position: 2
      prefix: -u
  - id: output_path
    type: string
    doc: output to file
    inputBinding:
      position: 3
      prefix: -o
  - id: scaffolds_agp
    type: File
    doc: scaffolds AGP file
    inputBinding:
      position: 4
  - id: contigs_fa
    type: File
    doc: contigs FASTA file
    inputBinding:
      position: 5
outputs:
  - id: output
    type: File
    doc: scaffold FASTA file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
