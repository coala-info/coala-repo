cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-cli-filter-sce.R
label: scran-cli_scran-cli-filter-sce.R
doc: "Filter cells and genes of a SingleCellExperiment object, add spike-in genes and optionally log-transform counts.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: input_sce_object
    type: File
    doc: "Path to the input SCE object in rds format."
    inputBinding:
      prefix: --input-sce-object
  - id: exprs_values
    type: ['null', string]
    doc: "String indicating which assay contains the count data that should be used to compute log-transformed expression values."
    inputBinding:
      prefix: --exprs-values
  - id: min_genes
    type: ['null', int]
    doc: "Minimum number of genes to be expressed per cell to pass filtering."
    inputBinding:
      prefix: --min-genes
  - id: min_cells
    type: ['null', int]
    doc: "Minimum number of cells for a gene to be expressed to pass filtering."
    inputBinding:
      prefix: --min-cells
  - id: spikes
    type: ['null', string]
    doc: "String or integer scalar specifying the alternative experiment containing the spike-in transcripts. Default: ERCC"
    inputBinding:
      prefix: --spikes
  - id: n_spikes
    type: ['null', int]
    doc: "Integer specifying the number of genes to add as spike-ins in case there is are no spike-ins in the ERCC slot. Default: 25."
    inputBinding:
      prefix: --n-spikes
  - id: log
    type: ['null', string]
    doc: "Logical specifying wether log-transformation of CPM counts should be performed. (TRUE or FALSE)"
    inputBinding:
      prefix: --log
  - id: output_sce_object_path
    type: string
    doc: "File name in which to store serialized R object of type SingleCellExperiment."
    inputBinding:
      prefix: --output-sce-object
outputs:
  - id: output_sce_object
    type: File
    doc: "Serialized filtered SingleCellExperiment object"
    outputBinding:
      glob: $(inputs.output_sce_object_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
