cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedRemoveOverlap
label: ucsc-bedremoveoverlap
doc: "Remove overlapping records from a (sorted) bed file. Gets rid of the smaller
  of overlapping records.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bed
    type: File
    doc: Input BED file, sorted by chromosome and start.
    inputBinding:
      position: 1
  - id: out_bed
    type: string
    doc: Name of the output BED file.
    inputBinding:
      position: 2
outputs:
  - id: output_bed
    type: File
    doc: BED file without overlapping records.
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedremoveoverlap:482--h0b57e2e_0
