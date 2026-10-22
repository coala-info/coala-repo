cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-trend-var.R
label: scran-cli_scran-trend-var.R
doc: "Fit a mean-dependent trend to the gene-specific variances in single-cell RNA-seq data.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: input_sce_object
    type: File
    doc: "Path to the input SCE object in rds format."
    inputBinding:
      prefix: --input-sce-object
  - id: min_mean
    type: ['null', double]
    doc: "A numeric scalar specifying the minimum mean to use for trend fitting."
    inputBinding:
      prefix: --min-mean
  - id: method
    type: ['null', string]
    doc: "A string specifying the algorithm to use for smooth trend fitting."
    inputBinding:
      prefix: --method
  - id: parametric
    type: ['null', string]
    doc: "A logical scalar indicating whether a parametric fit should be attempted. (TRUE or FALSE)"
    inputBinding:
      prefix: --parametric
  - id: assay_type
    type: ['null', string]
    doc: "String or integer scalar specifying the assay containing the log-expression values. Default: logcounts"
    inputBinding:
      prefix: --assay-type
  - id: use_spikes
    type: ['null', string]
    doc: "If FALSE only the rows not labelled as spike-in transcripts will be used. If TRUE, only rows labelled as spike-ins will be used. (TRUE or FALSE)"
    inputBinding:
      prefix: --use-spikes
  - id: output_trend_var_path
    type: string
    doc: "Path to the RDS object with named list containing: mean, var, resid.df, block, design, trend, df2."
    inputBinding:
      prefix: --output-trend-var
outputs:
  - id: output_trend_var
    type: File
    doc: "RDS object with the fitted variance trend"
    outputBinding:
      glob: $(inputs.output_trend_var_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
