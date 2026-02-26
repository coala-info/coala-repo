cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-compute-spike-factors.R
label: scran-cli_scran-compute-spike-factors.R
doc: "Compute spike-in size factors for SingleCellExperiment objects.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: assay_type
    type:
      - 'null'
      - string
    doc: Specify which assay values to use.
    default: logcounts
    inputBinding:
      position: 101
      prefix: --assay-type
  - id: general_use
    type:
      - 'null'
      - boolean
    doc: A logical scalar indicating whether the size factors should be stored 
      for general use by all genes.
    inputBinding:
      position: 101
      prefix: --general_use
  - id: input_sce_object
    type: File
    doc: Path to the input SCE object in rds format.
    inputBinding:
      position: 101
      prefix: --input-sce-object
  - id: type
    type:
      - 'null'
      - string
    doc: A character vector specifying which spike-in sets to use.
    default: ERCC
    inputBinding:
      position: 101
      prefix: --type
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
