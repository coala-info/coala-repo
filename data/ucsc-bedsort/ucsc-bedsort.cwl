cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedSort
label: ucsc-bedsort
doc: "Sort a .bed file by chrom,chromStart. The input and output may be the same file.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bed
    type: File
    doc: Input BED file.
    inputBinding:
      position: 1
  - id: out_bed
    type: string
    doc: Name of the sorted output BED file.
    inputBinding:
      position: 2
outputs:
  - id: output_bed
    type: File
    doc: BED file sorted by chrom and chromStart.
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedsort:482--h0b57e2e_0
