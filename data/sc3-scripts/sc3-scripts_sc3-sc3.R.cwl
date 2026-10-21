cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3.R
label: sc3-scripts_sc3-sc3.R
doc: "Runs the whole SC3 consensus clustering (prepare, distances, transformations, k-means, consensus and optionally biology) on a SingleCellExperiment object in one step.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R SingleCellExperiment object where
      object matrix found
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: ks
    type:
      - 'null'
      - string
    doc: A comma-separated string or single value representing the number of
      clusters k to be used for SC3 clustering.
    inputBinding:
      position: 101
      prefix: --ks
  - id: gene_filter
    type:
      - 'null'
      - string
    doc: TRUE or FALSE. Defines whether to perform gene filtering before SC3
      clustering (default FALSE).
    inputBinding:
      position: 101
      prefix: --gene-filter
  - id: pct_dropout_min
    type:
      - 'null'
      - int
    doc: If gene_filter = TRUE, then genes with percent of dropouts smaller than
      pct_dropout_min are filtered out before clustering.
    inputBinding:
      position: 101
      prefix: --pct-dropout-min
  - id: pct_dropout_max
    type:
      - 'null'
      - int
    doc: If gene_filter = TRUE, then genes with percent of dropouts larger than
      pct_dropout_max are filtered out before clustering.
    inputBinding:
      position: 101
      prefix: --pct-dropout-max
  - id: d_region_min
    type:
      - 'null'
      - float
    doc: Defines the minimum number of eigenvectors used for kmeans clustering
      as a fraction of the total number of cells. Default is 0.04.
    inputBinding:
      position: 101
      prefix: --d-region-min
  - id: d_region_max
    type:
      - 'null'
      - float
    doc: Defines the maximum number of eigenvectors used for kmeans clustering
      as a fraction of the total number of cells. Default is 0.07.
    inputBinding:
      position: 101
      prefix: --d-region-max
  - id: svm_num_cells
    type:
      - 'null'
      - int
    doc: Number of randomly selected training cells to be used for SVM
      prediction. Default is NULL.
    inputBinding:
      position: 101
      prefix: --svm-num-cells
  - id: svm_train_inds
    type:
      - 'null'
      - File
    doc: Text file with one integer per line, defining indices of training cells
      for SVM training. Default is NULL.
    inputBinding:
      position: 101
      prefix: --svm-train-inds
  - id: svm_max
    type:
      - 'null'
      - int
    doc: Define the maximum number of cells below which SVM are not run.
    inputBinding:
      position: 101
      prefix: --svm-max
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Number of threads/cores to be used in the user's machine.
    inputBinding:
      position: 101
      prefix: --n-cores
  - id: kmeans_nstart
    type:
      - 'null'
      - int
    doc: nstart parameter passed to kmeans function. Default is 1000 for up to
      2000 cells and 50 for more than 2000 cells.
    inputBinding:
      position: 101
      prefix: --kmeans-nstart
  - id: kmeans_iter_max
    type:
      - 'null'
      - float
    doc: iter.max parameter passed to kmeans function. Default is 1e+09.
    inputBinding:
      position: 101
      prefix: --kmeans-iter-max
  - id: k_estimator
    type:
      - 'null'
      - string
    doc: TRUE or FALSE. Defines whether to estimate an optimal number of
      clusters. If ks is given, the estimation does not change it.
    inputBinding:
      position: 101
      prefix: --k_estimator
  - id: biology
    type:
      - 'null'
      - string
    doc: TRUE or FALSE. Defines whether to compute differentially expressed
      genes, marker genes and cell outliers.
    inputBinding:
      position: 101
      prefix: --biology
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: Sets the seed of the random number generator.
    inputBinding:
      position: 101
      prefix: --rand-seed
  - id: output_object_file_path
    type: string
    doc: File name in which to store serialized R object of type
      'SingleCellExperiment'.
    inputBinding:
      position: 102
      prefix: --output-object-file
outputs:
  - id: output_object_file
    type: File
    doc: Serialized R SingleCellExperiment object with the SC3 results.
    outputBinding:
      glob: $(inputs.output_object_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
