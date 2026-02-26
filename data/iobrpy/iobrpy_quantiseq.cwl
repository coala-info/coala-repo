cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - quantiseq
label: iobrpy_quantiseq
doc: "Performs deconvolution of immune cell proportions from gene expression data.\n\
  \nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: arrays
    type:
      - 'null'
      - boolean
    doc: Perform quantile normalization on array data before deconvolution
    inputBinding:
      position: 101
      prefix: --arrays
  - id: input
    type: File
    doc: Path to the input mixture matrix TSV/CSV file (genes x samples)
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: 'Deconvolution method: lsei (least squares) or robust norms'
    inputBinding:
      position: 101
      prefix: --method
  - id: rmgenes
    type:
      - 'null'
      - string
    doc: "Genes to remove: 'default', 'none', or comma-separated list"
    inputBinding:
      position: 101
      prefix: --rmgenes
  - id: scale_mrna
    type:
      - 'null'
      - boolean
    doc: Enable mRNA scaling; use raw signature proportions otherwise
    inputBinding:
      position: 101
      prefix: --scale_mrna
  - id: signame
    type:
      - 'null'
      - string
    doc: Name of the signature set to use
    default: TIL10
    inputBinding:
      position: 101
      prefix: --signame
  - id: tumor
    type:
      - 'null'
      - boolean
    doc: Remove genes with high expression in tumor samples
    inputBinding:
      position: 101
      prefix: --tumor
outputs:
  - id: output
    type: File
    doc: Path to save the deconvolution results TSV
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
