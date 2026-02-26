cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk_rename
label: gfftk_rename
doc: "rename gene models in GFF3 annotation file. Script will sort genes by contig
  and location and then rename using --locus-tag, ie PREFIX_000001.\n\nTool homepage:
  https://github.com/nextgenusfs/gfftk"
inputs:
  - id: fasta
    type: File
    doc: genome in FASTA format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff3
    type: File
    doc: annotation in GFF3 format
    inputBinding:
      position: 101
      prefix: --gff3
  - id: locus_tag
    type: string
    doc: Locus tag for gene names
    inputBinding:
      position: 101
      prefix: --locus-tag
  - id: numbering
    type:
      - 'null'
      - int
    doc: 'start locus tag numbering (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --numbering
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: 'write santized GFF3 output to file (default: stdout)'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
