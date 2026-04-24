cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-build-snn-graph.R
label: scran-cli_scran-build-snn-graph.R
doc: "Builds a Shared Nearest Neighbor (SNN) graph or a k-Nearest Neighbor (kNN) graph
  from a Single-Cell Experiment (SCE) object.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: assay_type
    type:
      - 'null'
      - string
    doc: 'A string specifying which assay values to use. Default: logcounts.'
    inputBinding:
      position: 101
      prefix: --assay-type
  - id: d_value
    type: int
    doc: An integer scalar specifying the number of dimensions to use for the 
      search.
    inputBinding:
      position: 101
      prefix: --d-value
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
  - id: k_value
    type: int
    doc: An integer scalar specifying the number of nearest neighbors to 
      consider during graph construction.
    inputBinding:
      position: 101
      prefix: --k-value
  - id: shared
    type: boolean
    doc: Logical specifying wether to compute a Shared NN Graph (if shared=TRUE)
      or a kNN Graph(if shared=FALSE).
    inputBinding:
      position: 101
      prefix: --shared
  - id: subset_row
    type:
      - 'null'
      - string
    doc: Logical, integer or character vector specifying the rows for which to 
      model the variance. Defaults to all genes in x.
    inputBinding:
      position: 101
      prefix: --subset_row
  - id: transposed
    type:
      - 'null'
      - boolean
    doc: A logical scalar indicating whether x is transposed (i.e., rows are 
      cells).
    inputBinding:
      position: 101
      prefix: --transposed
  - id: type
    type:
      - 'null'
      - string
    doc: A string specifying the type of weighting scheme to use for shared 
      neighbors.
    inputBinding:
      position: 101
      prefix: --type
  - id: use_dimred
    type:
      - 'null'
      - string
    doc: A string specifying whether existing values in reducedDims(x) should be
      used.
    inputBinding:
      position: 101
      prefix: --use-dimred
outputs:
  - id: output_igraph_object
    type: File
    doc: Path to the output igraph object in RDS format.
    outputBinding:
      glob: $(inputs.output_igraph_object)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
