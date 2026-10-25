cwlVersion: v1.2
class: CommandLineTool
baseCommand: overlapSelect
label: ucsc-overlapselect
doc: "Select records based on overlapping chromosome ranges. The ranges are specified
  in the selectFile, with each block specifying a range. Records are copied from the
  inFile to outFile based on the selection criteria. Selection is based on blocks
  or exons rather than entire range.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: select_file
    type: File
    doc: File with the ranges to select against (selectFile)
    inputBinding:
      position: 1
  - id: in_file
    type: File
    doc: File with the records to select from (inFile)
    inputBinding:
      position: 2
  - id: out_file_name
    type: string
    doc: Output file name (outFile)
    inputBinding:
      position: 3
  - id: select_fmt
    type:
      - 'null'
      - string
    doc: "specify selectFile format: psl, pslq, genePred, bed, bed3+, bed6+, chain or chainq"
    inputBinding:
      position: 0
      prefix: -selectFmt=
      separate: false
  - id: select_coord_cols
    type:
      - 'null'
      - string
    doc: "selectFile is tab-separate with coordinates as described by spec: chromCol, or chromCol,startCol,endCol,strandCol,name (column numbers are zero-based)"
    inputBinding:
      position: 0
      prefix: -selectCoordCols=
      separate: false
  - id: select_cds
    type:
      - 'null'
      - boolean
    doc: "Use only CDS in the selectFile"
    inputBinding:
      position: 0
      prefix: -selectCds
  - id: select_range
    type:
      - 'null'
      - boolean
    doc: "Use entire range instead of blocks from records in the selectFile"
    inputBinding:
      position: 0
      prefix: -selectRange
  - id: in_fmt
    type:
      - 'null'
      - string
    doc: "specify inFile format, same values as -selectFmt"
    inputBinding:
      position: 0
      prefix: -inFmt=
      separate: false
  - id: in_coord_cols
    type:
      - 'null'
      - string
    doc: "inFile is tab-separate with coordinates specified by spec, in the format described for -selectCoordCols"
    inputBinding:
      position: 0
      prefix: -inCoordCols=
      separate: false
  - id: in_cds
    type:
      - 'null'
      - boolean
    doc: "Use only CDS in the inFile"
    inputBinding:
      position: 0
      prefix: -inCds
  - id: in_range
    type:
      - 'null'
      - boolean
    doc: "Use entire range instead of blocks of records in the inFile"
    inputBinding:
      position: 0
      prefix: -inRange
  - id: non_overlapping
    type:
      - 'null'
      - boolean
    doc: "select non-overlapping instead of overlapping records"
    inputBinding:
      position: 0
      prefix: -nonOverlapping
  - id: strand
    type:
      - 'null'
      - boolean
    doc: "must be on the same strand to be considered overlapping"
    inputBinding:
      position: 0
      prefix: -strand
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: "must be on the opposite strand to be considered overlapping"
    inputBinding:
      position: 0
      prefix: -oppositeStrand
  - id: exclude_self
    type:
      - 'null'
      - boolean
    doc: "don't compare records with the same coordinates and name"
    inputBinding:
      position: 0
      prefix: -excludeSelf
  - id: id_match
    type:
      - 'null'
      - boolean
    doc: "only select overlapping records if they have the same id"
    inputBinding:
      position: 0
      prefix: -idMatch
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: "compute overlap based on the total number of inFile bases overlapped by selectFile records (not with -overlapSimilarity and -mergeOutput)"
    inputBinding:
      position: 0
      prefix: -aggregate
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: "minimum fraction of an inFile record that must be overlapped by a single select record. Default is 0.0"
    inputBinding:
      position: 0
      prefix: -overlapThreshold=
      separate: false
  - id: overlap_threshold_ceil
    type:
      - 'null'
      - float
    doc: "select only inFile records with less than this fraction of overlap with a single record"
    inputBinding:
      position: 0
      prefix: -overlapThresholdCeil=
      separate: false
  - id: overlap_similarity
    type:
      - 'null'
      - float
    doc: "minimum fraction of bases in inFile and selectFile records that overlap the same genomic locations: (2*overlapBase)/(inFileBase+selectFileBases). Default is 0.0"
    inputBinding:
      position: 0
      prefix: -overlapSimilarity=
      separate: false
  - id: overlap_similarity_ceil
    type:
      - 'null'
      - float
    doc: "select only inFile records with less than this amount of similarity with a single record"
    inputBinding:
      position: 0
      prefix: -overlapSimilarityCeil=
      separate: false
  - id: overlap_bases
    type:
      - 'null'
      - int
    doc: "minimum number of bases of overlap, < 0 disables"
    inputBinding:
      position: 0
      prefix: -overlapBases=
      separate: false
  - id: stats_output
    type:
      - 'null'
      - boolean
    doc: "output overlap statistics instead of selected records (columns inId selectId inOverlap selectOverlap overBases)"
    inputBinding:
      position: 0
      prefix: -statsOutput
  - id: stats_output_all
    type:
      - 'null'
      - boolean
    doc: "like -statsOutput, but output all inFile records, including those that are not overlapped"
    inputBinding:
      position: 0
      prefix: -statsOutputAll
  - id: stats_output_both
    type:
      - 'null'
      - boolean
    doc: "like -statsOutput, but output all selectFile and inFile records, including those that are not overlapped"
    inputBinding:
      position: 0
      prefix: -statsOutputBoth
  - id: merge_output
    type:
      - 'null'
      - boolean
    doc: "output file is a merge of the input file with the selectFile records that selected it (inRec<tab>selectRec)"
    inputBinding:
      position: 0
      prefix: -mergeOutput
  - id: id_output
    type:
      - 'null'
      - boolean
    doc: "output a tab-separated file of pairs of inId selectId"
    inputBinding:
      position: 0
      prefix: -idOutput
  - id: dropped
    type:
      - 'null'
      - string
    doc: "output rows that were dropped to this file"
    inputBinding:
      position: 0
      prefix: -dropped=
      separate: false
  - id: verbose
    type:
      - 'null'
      - int
    doc: "verbose > 1 prints some details"
    inputBinding:
      position: 0
      prefix: -verbose=
      separate: false
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: "output TSV headers instead of autoSql headers for statistics output"
    inputBinding:
      position: 0
      prefix: -tsv
outputs:
  - id: out_file
    type: File
    doc: Selected records (or statistics, ids or merged records with the matching options)
    outputBinding:
      glob: $(inputs.out_file_name)
  - id: dropped_file
    type:
      - 'null'
      - File
    doc: Rows that were dropped, written by -dropped
    outputBinding:
      glob: $(inputs.dropped)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-overlapselect:482--h0b57e2e_0
