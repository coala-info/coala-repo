cwlVersion: v1.2
class: CommandLineTool
baseCommand: transMapPslToGenePred
label: ucsc-transmappsltogenepred
doc: "Convert PSL alignments of mRNAs to gene annotations. Converts transMap PSL alignments,\
  \ where the source genes are genomic annotations in genePred format, to a new genePred.\n\
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: source_gene_pred
    type: File
    doc: Source genePred file.
    inputBinding:
      position: 2
  - id: mapped_psl
    type: File
    doc: Mapped PSL file from transMap.
    inputBinding:
      position: 3
  - id: mapped_gene_pred
    type: string
    doc: Output mapped genePred file name.
    inputBinding:
      position: 4
  - id: non_coding_gap_fill_max
    type:
      - 'null'
      - int
    doc: Fill gaps in non-coding regions up to this many bases in length (default 0).
    inputBinding:
      position: 1
      prefix: -nonCodingGapFillMax=
      separate: false
  - id: coding_gap_fill_max
    type:
      - 'null'
      - int
    doc: Fill gaps in coding regions up to this many bases in length (default 0). Only coding gaps that are a multiple of three are filled, with the max rounded down.
    inputBinding:
      position: 1
      prefix: -codingGapFillMax=
      separate: false
  - id: no_block_merge
    type:
      - 'null'
      - boolean
    doc: Do not do any block merging of genePred, even of adjacent blocks. Mainly for debugging.
    inputBinding:
      position: 1
      prefix: -noBlockMerge
  - id: frame_shifts
    type:
      - 'null'
      - string
    doc: Name of a TSV file to write with locations of frame-shifting indels.
    inputBinding:
      position: 1
      prefix: -frameShifts=
      separate: false
outputs:
  - id: mapped_gene_pred_out
    type: File
    doc: Output mapped genePred file.
    outputBinding:
      glob: $(inputs.mapped_gene_pred)
  - id: frame_shifts_out
    type:
      - 'null'
      - File
    doc: TSV file with locations of frame-shifting indels.
    outputBinding:
      glob: $(inputs.frame_shifts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-transmappsltogenepred:482--h0b57e2e_1
