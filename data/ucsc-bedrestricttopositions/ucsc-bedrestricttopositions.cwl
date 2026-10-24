cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedRestrictToPositions
label: ucsc-bedrestricttopositions
doc: "Filter bed file, restricting to only ones that match chrom/start/ends specified
  in restrict.bed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bed
    type: File
    doc: Input BED file to filter.
    inputBinding:
      position: 1
  - id: restrict_bed
    type: File
    doc: BED file with the chrom/start/end positions to keep.
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    doc: Name of the output BED file.
    inputBinding:
      position: 3
outputs:
  - id: output_bed
    type: File
    doc: Records of the input whose chrom/start/end are in the restrict file.
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedrestricttopositions:482--h0b57e2e_0
