cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixClusterColumns
label: ucsc-matrixclustercolumns
doc: "Group the columns of a matrix into clusters, and output a matrix with the same\
  \ number of rows and generally much fewer columns. Combines columns by taking mean.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: extra_clustering
        type: record
        fields:
          - name: cluster
            type: string
            doc: Name of the field in meta.tsv with the cluster names
            inputBinding:
              position: 1
          - name: out_matrix
            type: string
            doc: Output matrix file name for this clustering
            inputBinding:
              position: 2
          - name: out_stats
            type: string
            doc: Output stats file name for this clustering
            inputBinding:
              position: 3
inputs:
  - id: in_matrix
    type: File
    doc: a file in tsv format with cell labels in first row and gene labels in 
      first column
    inputBinding:
      position: 1
  - id: meta
    type: File
    doc: a table where the first row is field labels and the first column is sample 
      ids
    inputBinding:
      position: 2
  - id: cluster
    type: string
    doc: the name of the field with the cluster names
    inputBinding:
      position: 3
  - id: out_matrix
    type: string
    doc: output matrix file name
    inputBinding:
      position: 4
  - id: out_stats
    type: string
    doc: output stats file name
    inputBinding:
      position: 5
  - id: extra_clusterings
    type:
      - 'null'
      - type: array
        items: extra_clustering
    doc: Additional cluster/outMatrix/outStats triples, to produce multiple clusterings
      in the same pass through the input matrix
    inputBinding:
      position: 6
  - id: make_index
    type:
      - 'null'
      - string
    doc: output index tsv file with <matrix-col1><input-file-pos><line-len>
    inputBinding:
      position: 101
      prefix: -makeIndex=
      separate: false
  - id: median
    type:
      - 'null'
      - boolean
    doc: if set output median rather than mean cluster value
    inputBinding:
      position: 101
      prefix: -median
  - id: exclude_zeros
    type:
      - 'null'
      - boolean
    doc: if set exclude zeros when calculating mean/median
    inputBinding:
      position: 101
      prefix: -excludeZeros
outputs:
  - id: out_out_matrix
    type: File
    doc: output matrix
    outputBinding:
      glob: $(inputs.out_matrix)
  - id: out_out_stats
    type: File
    doc: output stats
    outputBinding:
      glob: $(inputs.out_stats)
  - id: out_extra_files
    type:
      type: array
      items: File
    doc: Output matrix and stats files of the additional clusterings
    outputBinding:
      glob: '$((inputs.extra_clusterings || []).map(function(x) { return [x.out_matrix, x.out_stats]; }).reduce(function(a, b) { return a.concat(b); }, []))'
  - id: out_make_index
    type:
      - 'null'
      - File
    doc: index tsv file
    outputBinding:
      glob: $(inputs.make_index)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixclustercolumns:482--h0b57e2e_0
