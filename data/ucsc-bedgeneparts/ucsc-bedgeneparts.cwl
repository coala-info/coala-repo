cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedGeneParts
label: ucsc-bedgeneparts
doc: "Extract parts of genes (promoters, exons, introns, etc.) from BED files.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: Input BED file containing gene definitions.
    inputBinding:
      position: 1
  - id: part
    type: string
    doc: The part of the gene to extract (e.g., promoter, utr5, cds, utr3, exon, intron).
    inputBinding:
      position: 2
outputs:
  - id: output_bed
    type: File
    doc: Output BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgeneparts:482--h0b57e2e_0
