cwlVersion: v1.2
class: CommandLineTool
baseCommand: mask_gubbins_aln.py
label: gubbins_mask_gubbins_aln
doc: "Mask recombinant regions detected by Gubbins from the input alignment\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: aln
    type: File
    doc: "Input alignment (FASTA format)"
    inputBinding:
      position: 101
      prefix: --aln
  - id: gff
    type: File
    doc: "GFF of recombinant regions detected by Gubbins"
    inputBinding:
      position: 102
      prefix: --gff
  - id: out
    type: string
    doc: "Output file name"
    inputBinding:
      position: 103
      prefix: --out
  - id: out_fmt
    type:
      - 'null'
      - string
    doc: "Format of output alignment"
    inputBinding:
      position: 104
      prefix: --out-fmt
  - id: missing_char
    type:
      - 'null'
      - string
    doc: "Character used to replace recombinant sequence"
    inputBinding:
      position: 105
      prefix: --missing-char
outputs:
  - id: masked_alignment
    type: File
    doc: "Alignment with the recombinant regions masked"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
