cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - calculate_sig_score
label: iobrpy_calculate_sig_score
doc: "Calculate signature scores from an expression matrix.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: adjust_eset
    type:
      - 'null'
      - boolean
    doc: Apply additional filtering after log2 transform
    inputBinding:
      position: 101
      prefix: --adjust_eset
  - id: input_path
    type: File
    doc: Path to input expression matrix
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: Scoring method to apply
    default: pca
    inputBinding:
      position: 101
      prefix: --method
  - id: mini_gene_count
    type:
      - 'null'
      - int
    doc: Minimum genes per signature
    inputBinding:
      position: 101
      prefix: --mini_gene_count
  - id: parallel_size
    type:
      - 'null'
      - int
    doc: Threads for scoring (PCA/zscore/ssGSEA)
    inputBinding:
      position: 101
      prefix: --parallel_size
  - id: signature
    type:
      type: array
      items: string
    doc: "One or more signature GROUP names to use. Examples:\nsignature_collection
      signature_tme (space-separated),\nor signature_collection,signature_tme (comma-\n\
      separated). Supported groups include: go_bp, go_cc,\ngo_mf, signature_collection,
      signature_tme,\nsignature_sc, signature_tumor, signature_metabolism,\nkegg,
      hallmark, reactome, or \"all\" to use all groups."
    inputBinding:
      position: 101
      prefix: --signature
outputs:
  - id: output_path
    type: File
    doc: Path to save signature scores
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
