cwlVersion: v1.2
class: CommandLineTool
baseCommand: SourcePredict
label: sourcepredict
doc: "Coprolite source classification\n\nTool homepage: https://github.com/maxibor/sourcepredict"
inputs:
  - id: sink_table
    type: File
    doc: path to sink TAXID count table in csv format
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: Proportion of sink sample in unknown.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --alpha
  - id: dim
    type:
      - 'null'
      - int
    doc: Number of dimensions to retain for dimension reduction.
    default: 2
    inputBinding:
      position: 102
      prefix: --dim
  - id: distance
    type:
      - 'null'
      - string
    doc: Distance method. (unweighted_unifrac | weighted_unifrac)
    default: weighted_unifrac
    inputBinding:
      position: 102
      prefix: --distance
  - id: embed
    type:
      - 'null'
      - File
    doc: Output embedding csv file.
    default: None
    inputBinding:
      position: 102
      prefix: --embed
  - id: kfold
    type:
      - 'null'
      - int
    doc: Number of fold for K-fold cross validation in parameter optimization.
    default: 5
    inputBinding:
      position: 102
      prefix: --kfold
  - id: labels
    type:
      - 'null'
      - File
    doc: Path to labels csv file.
    default: data/modern_gut_microbiomes_labels.csv
    inputBinding:
      position: 102
      prefix: --labels
  - id: method
    type:
      - 'null'
      - string
    doc: Embedding Method. TSNE, MDS, or UMAP.
    default: TSNE
    inputBinding:
      position: 102
      prefix: --method
  - id: neighbors
    type:
      - 'null'
      - string
    doc: Numbers of neigbors if KNN ML classication (integer or 'all').
    default: 0 (chosen by CV)
    inputBinding:
      position: 102
      prefix: --neighbors
  - id: normalization
    type:
      - 'null'
      - string
    doc: Normalization method (RLE | Subsample | GMPR | None).
    default: GMPR
    inputBinding:
      position: 102
      prefix: --normalization
  - id: output
    type:
      - 'null'
      - string
    doc: Output file basename.
    default: <sample_basename>.sourcepredict.csv
    inputBinding:
      position: 102
      prefix: --output
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random generator.
    default: 42
    inputBinding:
      position: 102
      prefix: --seed
  - id: sources
    type:
      - 'null'
      - File
    doc: Path to source csv file.
    default: data/modern_gut_microbiomes_sources.csv
    inputBinding:
      position: 102
      prefix: --sources
  - id: tax_rank
    type:
      - 'null'
      - string
    doc: Taxonomic rank to use for Unifrac distances.
    default: species
    inputBinding:
      position: 102
      prefix: --tax_rank
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing.
    default: 2
    inputBinding:
      position: 102
      prefix: --threads
  - id: weights
    type:
      - 'null'
      - string
    doc: Sample weight function for KNN prediction (distance | uniform).
    default: distance.
    inputBinding:
      position: 102
      prefix: --weights
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourcepredict:0.5.1--pyhdfd78af_0
stdout: sourcepredict.out
