cwlVersion: v1.2
class: CommandLineTool
baseCommand: expMatrixToBarchartBed
label: ucsc-expmatrixtobarchartbed_expMatrixToBarchartBed
doc: "Generate a barChart bed6+5 file from a matrix, meta data, and coordinates.\n\
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: sample_file
    type: File
    doc: Two column no header, the first column is the samples which should 
      match the matrix, the second is the grouping (cell type, tissue, etc)
    inputBinding:
      position: 1
  - id: matrix_file
    type: File
    doc: The input matrix file. The samples in the first row should exactly 
      match the ones in the sampleFile. The labels (ex ENST*****) in the first 
      column should exactly match the ones in the bed file.
    inputBinding:
      position: 2
  - id: bed_file
    type: File
    doc: Bed6+1 format. File that maps the column labels from the matrix to 
      coordinates. Tab separated; chr, start coord, end coord, label, score, 
      strand, gene name. The score column is ignored.
    inputBinding:
      position: 3
  - id: auto_sql
    type:
      - 'null'
      - File
    doc: Optional autoSql description of extra fields in the input bed.
    inputBinding:
      position: 104
      prefix: --autoSql
  - id: group_order_file
    type:
      - 'null'
      - File
    doc: Optional file to define the group order, list the groups in a single 
      column in the order desired. The default ordering is alphabetical.
    inputBinding:
      position: 104
      prefix: --groupOrderFile
  - id: use_mean
    type:
      - 'null'
      - boolean
    doc: Calculate the group values using mean rather than median.
    inputBinding:
      position: 104
      prefix: --useMean
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show runtime messages.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: The output file, bed 6+5 format. See the schema in 
      kent/src/hg/lib/barChartBed.as.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/ucsc-expmatrixtobarchartbed:469--h664eb37_1
