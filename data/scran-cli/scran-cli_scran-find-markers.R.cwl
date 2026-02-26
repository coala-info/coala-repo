cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-find-markers.R
label: scran-cli_scran-find-markers.R
doc: "Finds marker genes for each cluster/group in a SingleCellExperiment object.\n\
  \nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: assay_type
    type:
      - 'null'
      - string
    doc: A character specifying which assay values to use.
    inputBinding:
      position: 101
      prefix: --assay-type
  - id: clusters
    type: string
    doc: A vector of group assignments for all cells.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: get_spikes
    type:
      - 'null'
      - boolean
    doc: Logical specifying wether to perform spike-ins filtering(FALSE) or not 
      (TRUE).
    inputBinding:
      position: 101
      prefix: --get-spikes
  - id: input_sce_object
    type: File
    doc: Path to the input SCE object in rds format.
    inputBinding:
      position: 101
      prefix: --input-sce-object
  - id: pvalue_type
    type:
      - 'null'
      - string
    doc: A character specifying how p-values are to be combined across pairwise 
      comparisons for a given group/cluster. Setting pval.type="all" requires a 
      gene to be DE between each cluster and every other cluster (rather than 
      any other cluster, as is the default with pval.type="any").
    default: any
    inputBinding:
      position: 101
      prefix: --pvalue-type
  - id: subset_row
    type:
      - 'null'
      - string
    doc: Logical, integer or character vector specifying the rows for which to 
      model the variance. Defaults to all genes in x.
    inputBinding:
      position: 101
      prefix: --subset_row
outputs:
  - id: output_markers
    type:
      - 'null'
      - File
    doc: Path to the rds list of DataFrames with a sorted marker gene list per 
      cluster/group.
    outputBinding:
      glob: $(inputs.output_markers)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
