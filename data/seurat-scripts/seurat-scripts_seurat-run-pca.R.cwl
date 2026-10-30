cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-run-pca.R
label: seurat-scripts_seurat-run-pca.R
doc: 'Run principal component analysis on a Seurat object (Seurat RunPCA).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R object of type 'Seurat'.'
    inputBinding:
      position: 2
      prefix: --output-object-file=
      separate: false
  - id: output_embeddings_file
    type: string
    doc: File name in which to store a csv-format embeddings table with PCs by cell.
    inputBinding:
      position: 3
      prefix: --output-embeddings-file=
      separate: false
  - id: output_loadings_file
    type: string
    doc: File name in which to store a csv-format loadings table with PCs by gene.
    inputBinding:
      position: 4
      prefix: --output-loadings-file=
      separate: false
  - id: output_stdev_file
    type: string
    doc: File name in which to store PC stdev values (one per line).
    inputBinding:
      position: 5
      prefix: --output-stdev-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 6
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 7
      prefix: --output-format=
      separate: false
  - id: pc_genes
    type:
      - 'null'
      - File
    doc: File with gene names to scale/center. Default is all genes in object@data.
    inputBinding:
      position: 8
      prefix: --pc-genes=
      separate: false
  - id: pc_cells
    type:
      - 'null'
      - File
    doc: File with cell names to scale/center. Default is all cells in object@data.
    inputBinding:
      position: 9
      prefix: --pc-cells=
      separate: false
  - id: pcs_compute
    type:
      - 'null'
      - int
    doc: Total Number of PCs to compute and store (50 by default).
    inputBinding:
      position: 10
      prefix: --pcs-compute=
      separate: false
  - id: reverse_pca
    type:
      - 'null'
      - boolean
    doc: By default computes the PCA on the cell x gene matrix. Setting to true will compute it on gene x cell matrix.
    inputBinding:
      position: 11
      prefix: --reverse-pca
  - id: no_weight_by_var
    type:
      - 'null'
      - boolean
    doc: Do not weight the cell embeddings by the variance of each PC (weights the gene loadings if rev.pca is TRUE)
    inputBinding:
      position: 12
      prefix: --no-weight-by-var
  - id: ndims_print
    type:
      - 'null'
      - int
    doc: PCs to print genes for
    inputBinding:
      position: 13
      prefix: --ndims-print=
      separate: false
  - id: nfeatures_print
    type:
      - 'null'
      - int
    doc: Number of genes to print for each PC
    inputBinding:
      position: 14
      prefix: --nfeatures-print=
      separate: false
  - id: reduction_key
    type:
      - 'null'
      - string
    doc: dimensional reduction key, specifies the string before the number for the dimension names. PC by default
    inputBinding:
      position: 15
      prefix: --reduction-key=
      separate: false
  - id: reduction_name
    type:
      - 'null'
      - string
    doc: dimensional reduction name, pca by default
    inputBinding:
      position: 16
      prefix: --reduction-name=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_embeddings_file
    type: File
    doc: File name in which to store a csv-format embeddings table with PCs by cell.
    outputBinding:
      glob: $(inputs.output_embeddings_file)
  - id: output_loadings_file
    type: File
    doc: File name in which to store a csv-format loadings table with PCs by gene.
    outputBinding:
      glob: $(inputs.output_loadings_file)
  - id: output_stdev_file
    type: File
    doc: File name in which to store PC stdev values (one per line).
    outputBinding:
      glob: $(inputs.output_stdev_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
