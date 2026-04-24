cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-compute-sum-factors.R
label: scran-cli_scran-compute-sum-factors.R
doc: "Computes size factors for single-cell RNA-seq data.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: assay_type
    type:
      - 'null'
      - string
    doc: Specify which assay values to use.
    inputBinding:
      position: 101
      prefix: --assay-type
  - id: clusters
    type:
      - 'null'
      - string
    doc: An optional factor specifying which cells belong to which cluster, for 
      deconvolution within clusters. For large data sets, clustering should be 
      performed with the quickCluster function before normalization.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: get_spikes
    type:
      - 'null'
      - boolean
    doc: If get-spikes = FALSE, spike-in transcripts are automatically removed. 
      If get.spikes=TRUE, no filtering on the spike-in transcripts will be 
      performed.
    inputBinding:
      position: 101
      prefix: --get-spikes
  - id: input_sce_object
    type: File
    doc: Path to the input SCE object in rds format.
    inputBinding:
      position: 101
      prefix: --input-sce-object
  - id: min_mean
    type:
      - 'null'
      - float
    doc: A numeric scalar specifying the minimum (library size-adjusted) average
      count of genes to be used for normalization.
    inputBinding:
      position: 101
      prefix: --min_mean
  - id: scaling
    type:
      - 'null'
      - float
    doc: A numeric scalar containing scaling factors to adjust the counts prior 
      to computing size factors.
    inputBinding:
      position: 101
      prefix: --scaling
  - id: sizes
    type:
      - 'null'
      - string
    doc: A numeric vector of pool sizes, i.e., number of cells per pool.
    inputBinding:
      position: 101
      prefix: --sizes
  - id: subset_row
    type:
      - 'null'
      - string
    doc: Logical, integer or character vector indicating the rows of SCE to use.
      If a character vector, it must contain the names of the rows in SCE.
    inputBinding:
      position: 101
      prefix: --subset-row
outputs:
  - id: output_sce_object
    type:
      - 'null'
      - File
    doc: Path to the output SCE object containing the vector of size factors in 
      sizeFactors(x).
    outputBinding:
      glob: $(inputs.output_sce_object)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
