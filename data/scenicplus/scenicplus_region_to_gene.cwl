cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - region_to_gene
label: scenicplus_region_to_gene
doc: "Infer region-to-gene adjacencies from chromatin accessibility and gene expression.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: multiome_mudata_fname
    type: File
    doc: "Path to multiome MuData object (from scenicplus prepare_GEX_ACC)."
    inputBinding:
      position: 101
      prefix: --multiome_mudata_fname
  - id: search_space_fname
    type: File
    doc: "Path to search space dataframe (from scenicplus search_spance)."
    inputBinding:
      position: 101
      prefix: --search_space_fname
  - id: temp_dir
    type: string
    doc: "Path temp dir."
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: out_region_to_gene_adjacencies_path
    type: string
    doc: "Path to store region to gene adjacencies (tsv)."
    inputBinding:
      position: 102
      prefix: --out_region_to_gene_adjacencies
  - id: importance_scoring_method
    type:
      - 'null'
      - string
    doc: "Regression method to use, either GBM (Gradient Boosting Machine), RF (Random Forrest) or ET (Extra Trees). Default is GBM."
    inputBinding:
      position: 101
      prefix: --importance_scoring_method
  - id: correlation_scoring_method
    type:
      - 'null'
      - string
    doc: "Correlation method to use, either PR (Pearson correlation) or SR (Spearman Rank correlation). Default is SR."
    inputBinding:
      position: 101
      prefix: --correlation_scoring_method
  - id: mask_expr_dropout
    type:
      - 'null'
      - boolean
    doc: "Whether to mask expression dropouts. Default is False."
    inputBinding:
      position: 101
      prefix: --mask_expr_dropout
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "Number of cores to use. Default is 1."
    inputBinding:
      position: 101
      prefix: --n_cpu
outputs:
  - id: out_region_to_gene_adjacencies
    type:
      - 'null'
      - File
    doc: "Path to store region to gene adjacencies (tsv)."
    outputBinding:
      glob: "$(inputs.out_region_to_gene_adjacencies_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
