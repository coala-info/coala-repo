cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusty
label: clusty
doc: "Clustering tool for pairwise distances or similarities\n\nTool homepage: https://github.com/refresh-bio/clusty"
inputs:
  - id: distances
    type: File
    doc: input TSV/CSV table with pairwise distances
    inputBinding:
      position: 1
  - id: algo
    type:
      - 'null'
      - string
    doc: 'clustering algorithm: single, complete, uclust, set-cover, cd-hit, or leiden'
    inputBinding:
      position: 102
      prefix: --algo
  - id: distance_col
    type:
      - 'null'
      - string
    doc: 'name of the column with pairwise distances (or similarities; default: third
      column)'
    inputBinding:
      position: 102
      prefix: --distance-col
  - id: id_cols
    type:
      - 'null'
      - type: array
        items: string
    doc: 'names of columns with sequence identifiers (default: two first columns)'
    inputBinding:
      position: 102
      prefix: --id-cols
  - id: leiden_beta
    type:
      - 'null'
      - float
    doc: beta parameter for Leiden algorithm
    default: 0.01
    inputBinding:
      position: 102
      prefix: --leiden-beta
  - id: leiden_iterations
    type:
      - 'null'
      - int
    doc: number of interations for Leiden algorithm
    default: 2
    inputBinding:
      position: 102
      prefix: --leiden-iterations
  - id: leiden_resolution
    type:
      - 'null'
      - float
    doc: resolution parameter for Leiden algorithm
    default: 0.7
    inputBinding:
      position: 102
      prefix: --leiden-resolution
  - id: max
    type:
      - 'null'
      - type: array
        items: string
    doc: accept pairwise connections with values lower or equal given threshold 
      in a specified column (expects <column-name> <real-threshold>)
    inputBinding:
      position: 102
      prefix: --max
  - id: min
    type:
      - 'null'
      - type: array
        items: string
    doc: accept pairwise connections with values greater or equal given 
      threshold in a specified column (expects <column-name> <real-threshold>)
    inputBinding:
      position: 102
      prefix: --min
  - id: numeric_ids
    type:
      - 'null'
      - boolean
    doc: use when sequences in the distances file are represented by numbers
    inputBinding:
      position: 102
      prefix: --numeric-ids
  - id: objects_file
    type:
      - 'null'
      - File
    doc: optional TSV/CSV file with object names in the first column sorted 
      decreasingly w.r.t. representativness
    inputBinding:
      position: 102
      prefix: --objects-file
  - id: out_csv
    type:
      - 'null'
      - boolean
    doc: output a CSV table instead of a default TSV
    default: false
    inputBinding:
      position: 102
      prefix: --out-csv
  - id: out_representatives
    type:
      - 'null'
      - boolean
    doc: output a representative object for each cluster instead of a cluster 
      numerical identifier
    default: false
    inputBinding:
      position: 102
      prefix: --out-representatives
  - id: percent_similarity
    type:
      - 'null'
      - boolean
    doc: use percent similarity (has to be in [0,100] interval)
    default: false
    inputBinding:
      position: 102
      prefix: --percent-similarity
  - id: similarity
    type:
      - 'null'
      - boolean
    doc: use similarity instead of distances (has to be in [0,1] interval)
    default: false
    inputBinding:
      position: 102
      prefix: --similarity
outputs:
  - id: assignments
    type: File
    doc: output TSV/CSV table with assignments
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusty:1.2.2--h9ee0642_0
