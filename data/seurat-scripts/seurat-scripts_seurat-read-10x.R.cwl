cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-read-10x.R
label: seurat-scripts_seurat-read-10x.R
doc: 'Read 10x or tab-separated expression data into a Seurat object (Seurat Read10X and CreateSeuratObject).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R matrix object.
    inputBinding:
      position: 1
      prefix: --output-object-file=
      separate: false
  - id: data_file
    type:
      - 'null'
      - File
    doc: A tab-separated file containing expression data.
    inputBinding:
      position: 2
      prefix: --data-file=
      separate: false
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the matrix.mtx, genes.tsv, and barcodes.tsv files matching 10X conventions (overrides --data-file).
    inputBinding:
      position: 3
      prefix: --data-dir=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 4
      prefix: --output-format=
      separate: false
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to a file with metdata for the cells, first column should be cell identifiers as used in the cells 10x file.
    inputBinding:
      position: 5
      prefix: --metadata=
      separate: false
  - id: min_cells
    type:
      - 'null'
      - int
    doc: Include features detected in at least this many cells. Will subset the counts matrix as well. To reintroduce excluded features, create a new object with a lower cutoff.
    inputBinding:
      position: 6
      prefix: --min-cells=
      separate: false
  - id: min_features
    type:
      - 'null'
      - int
    doc: Include cells where at least this many features are detected.
    inputBinding:
      position: 7
      prefix: --min-features=
      separate: false
  - id: gene_column
    type:
      - 'null'
      - int
    doc: Specify which column of genes.tsv or features.tsv to use for gene names; default is 2.
    inputBinding:
      position: 8
      prefix: --gene-column=
      separate: false
  - id: not_unique_features
    type:
      - 'null'
      - boolean
    doc: Do not make feature names unique (default FALSE - make them unique).
    inputBinding:
      position: 9
      prefix: --not-unique-features
  - id: project
    type:
      - 'null'
      - string
    doc: Sets the project name for the Seurat object.
    inputBinding:
      position: 10
      prefix: --project=
      separate: false
  - id: names_field
    type:
      - 'null'
      - int
    doc: For the initial identity class for each cell, choose this field for the cell's name. E.g. If your cells are named as BARCODE_CLUSTER_CELLTYPE in the input matrix, set names.field to 3 to set the initial identities to CELLTYPE.
    inputBinding:
      position: 11
      prefix: --names-field=
      separate: false
  - id: names_delim
    type:
      - 'null'
      - string
    doc: For the initial identity class for each cell, choose this delimiter from the cell's column name. E.g. If your cells are named as BARCODE-CLUSTER-CELLTYPE, set this to '-' to separate the cell name into its component parts for picking the relevant field.
    inputBinding:
      position: 12
      prefix: --names-delim=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R matrix object.
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
