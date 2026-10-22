cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-correlate-pairs.R
label: scran-cli_scran-correlate-pairs.R
doc: "Identify pairs of genes with significant correlations (correlatePairs).\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: input_sce_object
    type: File
    doc: "Path to the input SCE object in rds format."
    inputBinding:
      prefix: --input-sce-object
  - id: block
    type: ['null', string]
    doc: "A factor specifying the blocking levels for each cell in sce, for instance a donor covariate. If specified, correlations are computed separately within each block and statistics are combined across blocks."
    inputBinding:
      prefix: --block
  - id: design
    type: ['null', string]
    doc: "A numeric design matrix containing uninteresting factors to be ignored."
    inputBinding:
      prefix: --design
  - id: assay_type
    type: ['null', string]
    doc: "A character specifying which assay values to use."
    inputBinding:
      prefix: --assay-type
  - id: iters
    type: ['null', int]
    doc: "Integer scalar specifying the number of iterations to use in correlateNull to build the null distribution."
    inputBinding:
      prefix: --iters
  - id: use_names
    type: ['null', string]
    doc: "A logical scalar specifying whether the row names of x should be used in the output. Alternatively, a character vector containing the names to use."
    inputBinding:
      prefix: --use-names
  - id: subset_row
    type: ['null', string]
    doc: "Logical, integer or character vector specifying the rows for which to model the variance. Defaults to all genes in x."
    inputBinding:
      prefix: --subset_row
  - id: get_spikes
    type: ['null', string]
    doc: "Logical specifying wether to perform spike-ins filtering(FALSE) or not (TRUE). (TRUE or FALSE)"
    inputBinding:
      prefix: --get-spikes
  - id: use_dimred
    type: ['null', string]
    doc: "A string specifying whether existing values in reducedDims(x) should be used."
    inputBinding:
      prefix: --use-dimred
  - id: output_pairs_df_path
    type: string
    doc: "Path to the output dataframe with one row per gene pair (rows order by increasing p-values) in txt format."
    inputBinding:
      prefix: --output-pairs-df
outputs:
  - id: output_pairs_df
    type: File
    doc: "Table with one row per gene pair, ordered by increasing p-value"
    outputBinding:
      glob: $(inputs.output_pairs_df_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
