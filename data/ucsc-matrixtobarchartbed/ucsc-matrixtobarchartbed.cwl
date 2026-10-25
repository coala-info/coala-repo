cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixToBarChartBed
label: ucsc-matrixtobarchartbed
doc: "Attach a labeled expression matrix to a bed file joining on the matrix's first\
  \ column and the bed's name column.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: matrix
    type: File
    doc: tab-separated values with the first row and column used as labels
    inputBinding:
      position: 1
  - id: mapping_bed
    type: File
    doc: maps a row of the matrix using the bed's name field and matrix's 1st field.
      The file is expected to have a 'name2' field as its last column and otherwise
      be at least bed 6. Only the first 6 fields plus the name2 field are used.
    inputBinding:
      position: 2
  - id: bar_chart_output
    type: string
    doc: Output barChart BED file name
    inputBinding:
      position: 3
  - id: bed_ix
    type:
      - 'null'
      - int
    doc: use the N'th column of the mapping.bed as the id column. Default 4
    inputBinding:
      position: 101
      prefix: -bedIx=
      separate: false
  - id: track_db
    type:
      - 'null'
      - string
    doc: output a trackDb stanza for this as a track (file name)
    inputBinding:
      position: 101
      prefix: -trackDb=
      separate: false
  - id: stats
    type:
      - 'null'
      - File
    doc: stats file from matrixClusterColumns, makes coloring in trackDb better
    inputBinding:
      position: 101
      prefix: -stats=
      separate: false
outputs:
  - id: out_bar_chart_output
    type: File
    doc: Output barChart BED file
    outputBinding:
      glob: $(inputs.bar_chart_output)
  - id: out_track_db
    type:
      - 'null'
      - File
    doc: trackDb stanza file
    outputBinding:
      glob: $(inputs.track_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixtobarchartbed:482--h0b57e2e_0
