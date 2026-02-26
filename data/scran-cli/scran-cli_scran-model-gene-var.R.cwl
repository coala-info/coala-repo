cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-model-gene-var.R
label: scran-cli_scran-model-gene-var.R
doc: "Model gene variance using scran\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: assay_type
    type:
      - 'null'
      - string
    doc: String or integer scalar specifying the assay containing the 
      log-expression values.
    inputBinding:
      position: 101
      prefix: --assay-type
  - id: block
    type:
      - 'null'
      - string
    doc: A factor specifying the blocking levels for each cell in sce, for 
      instance a donor covariate. If specified, variance modelling is performed 
      separately within each block and statistics are combined across blocks.
    inputBinding:
      position: 101
      prefix: --block
  - id: design
    type:
      - 'null'
      - string
    doc: A numeric matrix containing blocking terms for uninteresting factors of
      variation.
    inputBinding:
      position: 101
      prefix: --design
  - id: equiweight
    type:
      - 'null'
      - boolean
    doc: A logical scalar indicating whether statistics from each block should 
      be given equal weight. Otherwise, each block is weighted according to its 
      number of cells. Only used if block is specified.
    inputBinding:
      position: 101
      prefix: --equiweight
  - id: input_sce_object
    type: File
    doc: Path to the input SCE object in rds format.
    inputBinding:
      position: 101
      prefix: --input-sce-object
  - id: method
    type:
      - 'null'
      - string
    doc: String specifying how p-values should be combined when block is 
      specified, see ?combinePValues.
    inputBinding:
      position: 101
      prefix: --method
  - id: min_mean
    type:
      - 'null'
      - float
    doc: A numeric scalar specifying the minimum mean to use for trend fitting.
    inputBinding:
      position: 101
      prefix: --min-mean
  - id: parametric
    type:
      - 'null'
      - boolean
    doc: 'A logical scalar indicating whether a parametric fit should be attempted.
      f parametric=TRUE, a non-linear curve of the form: y = ax/(x^n + b) s fitted
      to the variances against the means.'
    inputBinding:
      position: 101
      prefix: --parametric
  - id: subset_fit
    type:
      - 'null'
      - string
    doc: Logical, integer or character vector specifying the rows to be used for
      trend fitting. Defaults to subset.row.
    inputBinding:
      position: 101
      prefix: --subset-fit
  - id: subset_row
    type:
      - 'null'
      - string
    doc: Logical, integer or character vector specifying the rows for which to 
      model the variance. Defaults to all genes in x.
    inputBinding:
      position: 101
      prefix: --subset-row
outputs:
  - id: output_geneVar_table
    type:
      - 'null'
      - File
    doc: 'Path to the table where each row corresponds to a gene in sce, and contains:
      mean, total var, bio var, tech var, p.value and FDR.'
    outputBinding:
      glob: $(inputs.output_geneVar_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
