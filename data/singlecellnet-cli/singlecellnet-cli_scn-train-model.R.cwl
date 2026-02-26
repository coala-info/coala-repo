cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/scn-train-model.R
label: singlecellnet-cli_scn-train-model.R
doc: "Train a single cell classifier model.\n\nTool homepage: https://github.com/ebi-gene-expression-group/singlecellnet-cli"
inputs:
  - id: cell_barcode_col
    type: string
    doc: Name of the barcode column in object metadata.
    inputBinding:
      position: 101
      prefix: --cell-barcode-col
  - id: cell_type_col
    type: string
    doc: Name of the cell type annotation column in object metadata.
    inputBinding:
      position: 101
      prefix: --cell-type-col
  - id: dataset_id
    type: string
    doc: Name of the dataset used for training the classifier.
    inputBinding:
      position: 101
      prefix: --dataset-id
  - id: input_object
    type: File
    doc: Path to the input object with training data. SCE class in .rds format.
    inputBinding:
      position: 101
      prefix: --input-object
  - id: n_rand
    type: int
    doc: Number of random profiles to generate for training.
    inputBinding:
      position: 101
      prefix: --n-rand
  - id: n_top_gene_pairs
    type: int
    doc: The number of top gene pairs per category.
    inputBinding:
      position: 101
      prefix: --n-top-gene-pairs
  - id: n_top_genes
    type: int
    doc: The number of classification genes per category.
    inputBinding:
      position: 101
      prefix: --n-top-genes
  - id: n_trees
    type: int
    doc: Number of trees for random forest classifier
    inputBinding:
      position: 101
      prefix: --n-trees
  - id: stratify
    type:
      - 'null'
      - boolean
    doc: Should the 'stratify' parameter be set?
    inputBinding:
      position: 101
      prefix: --stratify
  - id: transprop_factor
    type:
      - 'null'
      - float
    doc: Scaling factor for transprop.
    inputBinding:
      position: 101
      prefix: --transprop-factor
  - id: weighted_down_threshold
    type:
      - 'null'
      - float
    doc: The threshold at which anything lower than that is 0 for weighted_down 
      function
    inputBinding:
      position: 101
      prefix: --weighted-down-threshold
  - id: weighted_down_total
    type:
      - 'null'
      - float
    doc: Numeric post transformation sum of read counts for weighted_down 
      function
    inputBinding:
      position: 101
      prefix: --weighted-down-total
outputs:
  - id: output_path
    type: Directory
    doc: Output path for the trained classifier.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
