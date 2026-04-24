cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett_train_classifier.R
label: garnett-cli_garnett_train_classifier.R
doc: "Train a cell type classifier using Garnett.\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: cds_gene_id_type
    type:
      - 'null'
      - string
    doc: Format of the gene IDs in your CDS object. The default is "ENSEMBL".
    inputBinding:
      position: 101
      prefix: --cds-gene-id-type
  - id: cds_object
    type:
      - 'null'
      - string
    doc: CDS object with expression data for training
    inputBinding:
      position: 101
      prefix: --cds-object
  - id: classifier_gene_id_type
    type:
      - 'null'
      - string
    doc: Optional. The type of gene ID that will be used in the classifier. If 
      possible for your organism, this should be 'ENSEMBL', which is the 
      default. Ignored if db = 'none'.
    inputBinding:
      position: 101
      prefix: --classifier-gene-id-type
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Optional. The number of cores to use for computation. Default: number returned
      by detectCores().'
    inputBinding:
      position: 101
      prefix: --cores
  - id: database
    type:
      - 'null'
      - string
    doc: argument for Bioconductor AnnotationDb-class package used for 
      converting gene IDs For example, use org.Hs.eg.db for Homo Sapiens genes.
    inputBinding:
      position: 101
      prefix: --database
  - id: lambdas
    type:
      - 'null'
      - File
    doc: Optional. Path to user-supplied lambda sequence (numeric vector in .rds
      format); default is NULL, and glmnet chooses its own sequence.
    inputBinding:
      position: 101
      prefix: --lambdas
  - id: marker_file_gene_id_type
    type:
      - 'null'
      - string
    doc: Format of the gene IDs in your marker file. The default is "SYMBOL".
    inputBinding:
      position: 101
      prefix: --marker-file-gene-id-type
  - id: marker_file_path
    type:
      - 'null'
      - File
    doc: File with marker genes specifying cell types. See 
      https://cole-trapnell-lab.github.io/garnett/docs/#constructing-a-marker-file
      for specification of the file format.
    inputBinding:
      position: 101
      prefix: --marker-file-path
  - id: max_training_samples
    type:
      - 'null'
      - int
    doc: An integer. The maximum number of representative cells per cell type to
      be included in the model training. Decreasing this number increases speed,
      but may hurt performance of the model. Default is 500.
    inputBinding:
      position: 101
      prefix: --max-training-samples
  - id: min_observations
    type:
      - 'null'
      - int
    doc: An integer. The minimum number of representative cells per cell type 
      required to include the cell type in the predictive model. Default is 8.
    inputBinding:
      position: 101
      prefix: --min-observations
  - id: num_unknown
    type:
      - 'null'
      - int
    doc: Number of outgroups to compare against. Default 500.
    inputBinding:
      position: 101
      prefix: --num-unknown
  - id: propogate_markers
    type:
      - 'null'
      - boolean
    doc: 'Optional. Should markers from child nodes of a cell type be used in finding
      representatives of the parent type? Default: TRUE.'
    inputBinding:
      position: 101
      prefix: --propogate-markers
  - id: train_id
    type:
      - 'null'
      - string
    doc: ID of the training dataset
    inputBinding:
      position: 101
      prefix: --train-id
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to the output file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
