cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - eGRN
label: scenicplus_eGRN
doc: "Infer enhancer-driven gene regulatory networks (eRegulons).\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: tf_to_gene_adj_fname
    type: File
    doc: "Path to TF-to-gene adjacencies (.tsv) from scenicplus TF_to_gene."
    inputBinding:
      position: 101
      prefix: --TF_to_gene_adj_fname
  - id: region_to_gene_adj_fname
    type: File
    doc: "Path to region-to-gene adjacencies (.tsv) from scenicplus region_to_gene."
    inputBinding:
      position: 101
      prefix: --region_to_gene_adj_fname
  - id: cistromes_fname
    type: File
    doc: "Path to either direct or extended cistromes (.h5ad) from scenicplus prepare_menr."
    inputBinding:
      position: 101
      prefix: --cistromes_fname
  - id: ranking_db_fname
    type: File
    doc: "Path to cistarget ranking database, this should be the same database as used for motif enrichment analysis using pyCistarget (.feather)"
    inputBinding:
      position: 101
      prefix: --ranking_db_fname
  - id: eregulon_out_fname_path
    type: string
    doc: "Path to save eRegulon dataframe (.tsv)"
    inputBinding:
      position: 102
      prefix: --eRegulon_out_fname
  - id: temp_dir
    type: string
    doc: "Path to temp dir."
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: is_extended
    type:
      - 'null'
      - boolean
    doc: "Use this when cistromes are based on extended annotation. Default is False."
    inputBinding:
      position: 101
      prefix: --is_extended
  - id: order_regions_to_genes_by
    type:
      - 'null'
      - string
    doc: "Column by which to order the region-to-gene links. Default is 'importance'."
    inputBinding:
      position: 101
      prefix: --order_regions_to_genes_by
  - id: order_tfs_to_genes_by
    type:
      - 'null'
      - string
    doc: "Column by which to order the TF-to-gene links. Default is 'importance'."
    inputBinding:
      position: 101
      prefix: --order_TFs_to_genes_by
  - id: gsea_n_perm
    type:
      - 'null'
      - int
    doc: "Number of permutations to run for GSEA. Default is 1000."
    inputBinding:
      position: 101
      prefix: --gsea_n_perm
  - id: quantiles
    type:
      - 'null'
      - type: array
        items: float
    doc: "Quantiles for thresholding region-to-gene links. Default is [0.85, 0.90, 0.95]"
    inputBinding:
      position: 101
      prefix: --quantiles
  - id: top_n_regiontogenes_per_gene
    type:
      - 'null'
      - type: array
        items: int
    doc: "Top n region-to-gene links per gene for thresholding region-to-gene links. Default is [5, 10, 15]"
    inputBinding:
      position: 101
      prefix: --top_n_regionTogenes_per_gene
  - id: top_n_regiontogenes_per_region
    type:
      - 'null'
      - type: array
        items: int
    doc: "Top n region-to-gene links per region for thresholding region-to-gene links. Default is []"
    inputBinding:
      position: 101
      prefix: --top_n_regionTogenes_per_region
  - id: do_not_binarize_using_basc
    type:
      - 'null'
      - boolean
    doc: "Don't use BASC to binarize region to gene links. By default BASC is used."
    inputBinding:
      position: 101
      prefix: --do_not_binarize_using_basc
  - id: min_regions_per_gene
    type:
      - 'null'
      - int
    doc: "Minimum regions per gene. Default is 0."
    inputBinding:
      position: 101
      prefix: --min_regions_per_gene
  - id: do_not_rho_dichotomize_tf2g
    type:
      - 'null'
      - boolean
    doc: "Don't split positive and negative TF-to-gene links. By default they are split."
    inputBinding:
      position: 101
      prefix: --do_not_rho_dichotomize_tf2g
  - id: do_not_rho_dichotomize_r2g
    type:
      - 'null'
      - boolean
    doc: "Don't split positive and negative region-to-gene links. By default they are split."
    inputBinding:
      position: 101
      prefix: --do_not_rho_dichotomize_r2g
  - id: do_not_rho_dichotomize_eregulon
    type:
      - 'null'
      - boolean
    doc: "Don't split positive and negative eRegulons. By default they are split."
    inputBinding:
      position: 101
      prefix: --do_not_rho_dichotomize_eRegulon
  - id: keep_only_activating_eregulons
    type:
      - 'null'
      - boolean
    doc: "Keep only activating eRegulons. By default both activating and repressive eRegulons are kept."
    inputBinding:
      position: 101
      prefix: --keep_only_activating_eRegulons
  - id: rho_threshold
    type:
      - 'null'
      - float
    doc: "Threshold on correlation coefficient used for splitting positive and negative interactions. Default is 0.05"
    inputBinding:
      position: 101
      prefix: --rho_threshold
  - id: min_target_genes
    type:
      - 'null'
      - int
    doc: "Minimum number of target genes per eRegulon, eRegulon with a lower number of target genes will be discarded. Default is 10"
    inputBinding:
      position: 101
      prefix: --min_target_genes
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "Number of cores to use. Default is 1."
    inputBinding:
      position: 101
      prefix: --n_cpu
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to use. Default is 666."
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: eregulon_out_fname
    type:
      - 'null'
      - File
    doc: "Path to save eRegulon dataframe (.tsv)"
    outputBinding:
      glob: "$(inputs.eregulon_out_fname_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
