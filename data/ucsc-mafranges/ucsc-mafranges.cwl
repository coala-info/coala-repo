cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafRanges
label: ucsc-mafranges
doc: "Extract ranges of target (or query) coverage from maf and output as BED 3 (e.g.\
  \ for processing by featureBits).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: db
    type: string
    doc: db should appear in in.maf alignments as the first part of "db.seqName"-style
      sequence names. The seqName part is used as the chrom field in the output BED.
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    doc: Output BED file name
    inputBinding:
      position: 3
  - id: other_db
    type:
      - 'null'
      - string
    doc: Output ranges only for alignments that include oDb. oDB can be comma-separated
      list.
    inputBinding:
      position: 101
      prefix: -otherDb=
      separate: false
  - id: not_all_o_gap
    type:
      - 'null'
      - boolean
    doc: Don't include bases for which all other species have a gap.
    inputBinding:
      position: 101
      prefix: -notAllOGap
outputs:
  - id: out_out_bed
    type: File
    doc: Output BED file
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafranges:482--h0b57e2e_0
