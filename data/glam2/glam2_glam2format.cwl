cwlVersion: v1.2
class: CommandLineTool
baseCommand: glam2format
label: glam2_glam2format
doc: "Convert a GLAM2 motif alignment to FASTA or MSF format\n\nTool homepage: https://github.com/LELEGOBOO/Glam2"
inputs:
  - id: format
    type: string
    doc: "Output format: fasta or msf"
    inputBinding:
      position: 10
  - id: motif
    type: File
    doc: "GLAM2 motif file (output of glam2)"
    inputBinding:
      position: 11
  - id: compact
    type:
      - 'null'
      - boolean
    doc: "make a compact alignment"
    inputBinding:
      position: 1
      prefix: -c
  - id: flank_sequences
    type:
      - 'null'
      - File
    doc: "sequence file for flanking sequences"
    inputBinding:
      position: 1
      prefix: -f
  - id: output_name
    type: string
    doc: "output file"
    default: glam2format_out.txt
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Reformatted alignment"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/glam2:v1064-5-deb_cv1
