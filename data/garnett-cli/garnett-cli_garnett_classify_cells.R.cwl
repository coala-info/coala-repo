cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett_classify_cells.R
label: garnett-cli_garnett_classify_cells.R
doc: "Query CDS object holding expression data to be classified\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: cds_gene_id_type
    type:
      - 'null'
      - string
    doc: Format of the gene IDs in your CDS object. The default is "ENSEMBL".
    default: ENSEMBL
    inputBinding:
      position: 101
      prefix: --cds-gene-id-type
  - id: cds_object
    type:
      - 'null'
      - string
    doc: Query CDS object holding expression data to be classified
    inputBinding:
      position: 101
      prefix: --cds-object
  - id: classifier_object
    type:
      - 'null'
      - string
    doc: Path to the object of class garnett_classifier, which is either trained
      via garnett_train_classifier.R or obtained previously
    inputBinding:
      position: 101
      prefix: --classifier-object
  - id: cluster_extend
    type:
      - 'null'
      - boolean
    doc: 'Boolean, tells Garnett whether to create a second set of assignments that
      expands classifications to cells in the same cluster. Default: TRUE'
    default: true
    inputBinding:
      position: 101
      prefix: --cluster-extend
  - id: database
    type:
      - 'null'
      - string
    doc: Argument for Bioconductor AnnotationDb-class package used for 
      converting gene IDs. For example, use org.Hs.eg.db for Homo Sapiens genes.
    inputBinding:
      position: 101
      prefix: --database
  - id: plot_output_path
    type:
      - 'null'
      - Directory
    doc: output path for the t-SNE plots. In case --cluster-extend tag is 
      provided, two plots will be made. If no path is provided, plots will not 
      be produced.
    inputBinding:
      position: 101
      prefix: --plot-output-path
  - id: rank_prob_ratio
    type:
      - 'null'
      - float
    doc: Numeric value greater than 1. This is the minimum odds ratio between 
      the probability of the most likely cell type to the second most likely 
      cell type to allow assignment. Default is 1.5. Higher values are more 
      conservative.
    default: 1.5
    inputBinding:
      position: 101
      prefix: --rank-prob-ratio
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Logical. Should progress messages be printed. Default: FASLE.'
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: cds_output_obj
    type:
      - 'null'
      - File
    doc: Output path for cds object holding predicted labels on query data
    outputBinding:
      glob: $(inputs.cds_output_obj)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
