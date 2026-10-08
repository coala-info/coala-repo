cwlVersion: v1.2
class: CommandLineTool
baseCommand: glam2mask
label: glam2_glam2mask
doc: "Mask the aligned columns of a GLAM2 motif in a sequence file\n\nTool homepage: https://github.com/LELEGOBOO/Glam2"
inputs:
  - id: motif
    type: File
    doc: "GLAM2 motif file (output of glam2)"
    inputBinding:
      position: 10
  - id: sequences
    type: File
    doc: "Sequence file in FASTA format"
    inputBinding:
      position: 11
  - id: mask_character
    type:
      - 'null'
      - string
    doc: "mask character (x)"
    inputBinding:
      position: 1
      prefix: -x
  - id: output_name
    type: string
    doc: "output file"
    default: glam2mask_out.fa
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Sequences with the motif sites masked"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/glam2:v1064-5-deb_cv1
