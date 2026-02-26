cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett-cli_garnett_check_markers.R
label: garnett-cli_garnett_check_markers.R
doc: "Check marker genes for cell types.\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: amb_marker_cutoff
    type:
      - 'null'
      - float
    doc: (Plotting option). Numeric; Cutoff at which to label ambiguous markers.
      Default 0.5.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --amb-marker-cutoff
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
    doc: CDS object with expression data
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
    default: ENSEMBL
    inputBinding:
      position: 101
      prefix: --classifier-gene-id-type
  - id: database
    type:
      - 'null'
      - string
    doc: argument for Bioconductor AnnotationDb-class package used for 
      converting gene IDs. For example, use org.Hs.eg.db for Homo Sapiens genes.
    inputBinding:
      position: 101
      prefix: --database
  - id: label_size
    type:
      - 'null'
      - float
    doc: (Plotting option). Numeric, size of the text labels for ambiguous 
      markers and unplotted markers.
    inputBinding:
      position: 101
      prefix: --label-size
  - id: marker_file_gene_id_type
    type:
      - 'null'
      - string
    doc: Format of the gene IDs in your marker file. The default is "ENSEMBL".
    default: ENSEMBL
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
  - id: plot_output_path
    type:
      - 'null'
      - File
    doc: Optional. If you would like to make a marker plot, provide a name 
      (path) for it.
    inputBinding:
      position: 101
      prefix: --plot-output-path
  - id: propogate_markers
    type:
      - 'null'
      - boolean
    doc: 'Optional. Should markers from child nodes of a cell type be used in finding
      representatives of the parent type? Default: TRUE.'
    default: true
    inputBinding:
      position: 101
      prefix: --propogate-markers
  - id: use_tf_idf
    type:
      - 'null'
      - boolean
    doc: 'Optional. Should TF-IDF matrix be calculated during estimation? If TRUE,
      estimates will be more accurate, but calculation is slower with very large datasets.
      Default: TRUE.'
    default: true
    inputBinding:
      position: 101
      prefix: --use-tf-idf
outputs:
  - id: marker_output_path
    type:
      - 'null'
      - File
    doc: Path to the output file with marker scores
    outputBinding:
      glob: $(inputs.marker_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
