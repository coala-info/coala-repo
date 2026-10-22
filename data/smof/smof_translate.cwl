cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - translate
label: smof_translate
doc: "Translate a DNA sequence into a protein sequence (standard genetic code).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: from_start
    type:
      - 'null'
      - boolean
    doc: "Require each product begin with a start codon"
    inputBinding:
      position: 100
      prefix: --from-start
  - id: all_frames
    type:
      - 'null'
      - boolean
    doc: "Translate in all frames, keep longest"
    inputBinding:
      position: 101
      prefix: --all-frames
  - id: cds
    type:
      - 'null'
      - boolean
    doc: "Write the DNA coding sequence"
    inputBinding:
      position: 102
      prefix: --cds
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_translate.out
