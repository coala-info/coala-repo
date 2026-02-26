cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/garnett_get_feature_genes.R
label: garnett-cli_garnett_get_feature_genes.R
doc: "Get feature genes for a given classifier object.\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: classifier_object
    type: File
    doc: path to the object of class garnett_classifier, which is either trained
      via garnett_train_classifier.R or obtained previously
    inputBinding:
      position: 101
      prefix: --classifier-object
  - id: convert_ids
    type:
      - 'null'
      - boolean
    doc: 'Boolean that indicates whether the gene IDs should be converted into SYMBOL
      notation. Default: FALSE'
    default: false
    inputBinding:
      position: 101
      prefix: --convert-ids
  - id: database
    type:
      - 'null'
      - string
    doc: argument for Bioconductor AnnotationDb-class package used for 
      converting gene IDs. For example, use org.Hs.eg.db for Homo Sapiens genes.
    inputBinding:
      position: 101
      prefix: --database
  - id: node
    type:
      - 'null'
      - string
    doc: In case a hierarchical marker tree was used to train the classifier, 
      specify which node features should be shown. Default is 'root'. For other 
      nodes, use the corresponding parent cell type name
    default: root
    inputBinding:
      position: 101
      prefix: --node
outputs:
  - id: output_path
    type: File
    doc: Path to the output file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
