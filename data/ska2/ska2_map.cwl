cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - map
label: ska2_map
doc: "Write an ordered alignment using a reference sequence\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: reference
    type: File
    doc: 'Reference FASTA file to map to'
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'A .skf file, or list of .fasta files'
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format of output file: vcf (variant call format) or aln (FASTA alignment) [default: aln]'
    inputBinding:
      position: 101
      prefix: --format
  - id: ambig_mask
    type:
      - 'null'
      - boolean
    doc: 'Mask any ambiguous bases in the alignment with ''N'''
    inputBinding:
      position: 101
      prefix: --ambig-mask
  - id: repeat_mask
    type:
      - 'null'
      - boolean
    doc: 'Mask any repeats in the alignment with ''N'''
    inputBinding:
      position: 101
      prefix: --repeat-mask
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_path
    type: string
    doc: 'Output filename'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: mapped
    type: File
    doc: 'Mapped alignment or VCF'
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
