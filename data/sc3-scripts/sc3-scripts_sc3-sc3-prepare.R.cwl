cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-prepare.R
label: sc3-scripts_sc3-sc3-prepare.R
doc: "Prepare SingleCellExperiment object for SC3 clustering.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: d_region_max
    type:
      - 'null'
      - float
    doc: Defines the maximum number of eigenvectors used for kmeans clustering 
      as a fraction of the total number of cells. Default is 0.07. See SC3 paper
      for more details.
    default: '0.07'
    inputBinding:
      position: 101
      prefix: --d-region-max
  - id: d_region_min
    type:
      - 'null'
      - float
    doc: Defines the minimum number of eigenvectors used for kmeans clustering 
      as a fraction of the total number of cells. Default is 0.04. See SC3 paper
      for more details.
    default: '0.04'
    inputBinding:
      position: 101
      prefix: --d-region-min
  - id: gene_filter
    type:
      - 'null'
      - boolean
    doc: A boolean variable which defines whether to perform gene filtering 
      before SC3 clustering.
    inputBinding:
      position: 101
      prefix: --gene-filter
  - id: input_object_file
    type:
      - 'null'
      - File
    doc: File name in which a serialized R SingleCellExperiment object where 
      object matrix found
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: kmeans_iter_max
    type:
      - 'null'
      - int
    doc: iter.max parameter passed to kmeans function. Default is 1e+09.
    default: '1e+09'
    inputBinding:
      position: 101
      prefix: --kmeans-iter-max
  - id: kmeans_nstart
    type:
      - 'null'
      - int
    doc: nstart parameter passed to kmeans function. Default is 1000 for up to 
      2000 cells and 50 for more than 2000 cells.
    default: 1000 for up to 2000 cells and 50 for more than 2000 cells
    inputBinding:
      position: 101
      prefix: --kmeans-nstart
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Number of threads/cores to be used in the user's machine.
    inputBinding:
      position: 101
      prefix: --n-cores
  - id: pct_dropout_max
    type:
      - 'null'
      - float
    doc: If gene_filter = TRUE, then genes with percent of dropouts larger than 
      pct_dropout_max are filtered out before clustering.
    inputBinding:
      position: 101
      prefix: --pct-dropout-max
  - id: pct_dropout_min
    type:
      - 'null'
      - float
    doc: If gene_filter = TRUE, then genes with percent of dropouts smaller than
      pct_dropout_min are filtered out before clustering.
    inputBinding:
      position: 101
      prefix: --pct-dropout-min
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: sets the seed of the random number generator. SC3 is a stochastic 
      method, so setting the rand_seed to a fixed values can be used for 
      reproducibility purposes.
    inputBinding:
      position: 101
      prefix: --rand-seed
  - id: svm_max
    type:
      - 'null'
      - int
    doc: Define the maximum number of cells below which SVM are not run.
    inputBinding:
      position: 101
      prefix: --svm-max
  - id: svm_num_cells
    type:
      - 'null'
      - int
    doc: Number of randomly selected training cells to be used for SVM 
      prediction. Default is NULL.
    default: 'NULL'
    inputBinding:
      position: 101
      prefix: --svm-num-cells
  - id: svm_train_inds
    type:
      - 'null'
      - File
    doc: Text file with one integer per line. Will be used to create a numeric 
      vector defining indices of training cells that should be used for SVM 
      training. The default is NULL.
    default: 'NULL'
    inputBinding:
      position: 101
      prefix: --svm-train-inds
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
