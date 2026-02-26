cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedExtendRanges
label: ucsc-bedextendranges
doc: "Extend BED ranges by a specified number of bases using the chromosome sizes
  from the specified database.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg19, mm10) to fetch chromosome sizes.
    inputBinding:
      position: 1
  - id: extension
    type: int
    doc: The number of bases to extend the ranges.
    inputBinding:
      position: 2
  - id: input_bed
    type: File
    doc: The input BED file.
    inputBinding:
      position: 3
outputs:
  - id: output_bed
    type: File
    doc: The output BED file where extended ranges will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedextendranges:482--h0b57e2e_0
