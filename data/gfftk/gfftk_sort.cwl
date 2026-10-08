cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfftk
  - sort
label: gfftk_sort
doc: "sort GFF3 file properly [maintain feature order: gene, mrna, exon, cds].\n\nTool
  homepage: https://github.com/nextgenusfs/gfftk"
inputs:
  - id: gff3
    type: File
    doc: GFF3 file to sort
    inputBinding:
      position: 101
      prefix: --gff3
  - id: out_path
    type: string
    doc: 'write sorted output to file (default: stdout)'
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: File
    doc: sorted GFF3 output
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
