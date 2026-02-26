cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkatlas
label: checkatlas
doc: "CheckAtlas is a one liner tool to check the quality of your single-cell atlases.
  For every atlas, it produces the quality control tables and figures which can be
  then processed by multiqc. CheckAtlas is able to load Scanpy, Seurat, and CellRanger
  files.\n\nTool homepage: https://checkatlas.readthedocs.io/"
inputs:
  - id: process
    type: string
    doc: "Required argument: Type of process to run among ['summary', 'qc', 'metric_cluster',
      'metric_annot', 'metric_dimred']"
    inputBinding:
      position: 1
  - id: atlas_name
    type: string
    doc: 'Required argument: The name of the atlas to process.Atlas_name should be
      found in one of the samplesheet provided tonf-checkatlas, or directly created
      by checkatlas.list_all_atlases() function'
    inputBinding:
      position: 2
  - id: search_folder
    type: Directory
    doc: 'Required argument: Your folder containing Scanpy, CellRanger and Seurat
      atlasesv'
    inputBinding:
      position: 3
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print out all debug messages.
    inputBinding:
      position: 104
      prefix: --debug
  - id: metric_annot
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the list of clustering metrics to calculate. Example: --metric_annot
      rand_index List of annotation metrics: ['rand_index', 'fowlkes_mallow', 'adj_mutual_info',
      'vmeasure', 'dunn_index', 'adj_rand_index', 'normalized_mutual_info', 'mutual_info',
      'isolated_f1_score']"
    inputBinding:
      position: 104
      prefix: --metric_annot
  - id: metric_cluster
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the list of clustering metrics to calculate. Example: --metric_cluster
      silhouette davies_bouldin List of cluster metrics: ['silhouette', 'davies_bouldin',
      'calinski_harabasz']"
    inputBinding:
      position: 104
      prefix: --metric_cluster
  - id: metric_dimred
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the list of dimensionality reduction metrics to calculate. Example:
      --metric_dimred kruskal_stress List of dim. red. metrics: ['kruskal_stress',
      'spearman_rho', 'entourage']"
    inputBinding:
      position: 104
      prefix: --metric_dimred
  - id: obs_cluster
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of obs from the adata file to use in the clustering metric calculus.Example:
      --obs_cluster celltype leuven seurat_clusters'
    inputBinding:
      position: 104
      prefix: --obs_cluster
  - id: plot_celllimit
    type:
      - 'null'
      - int
    doc: Set the maximum number of cellsto plot in QC, UMAP, t-SNE, etc....If 
      plot_celllimit=0, no limit willbe applied.
    inputBinding:
      position: 104
      prefix: --plot_celllimit
  - id: qc_display
    type:
      - 'null'
      - type: array
        items: string
    doc: List of QC to display. Available qc = violin_plot, total_counts, 
      n_genes_by_counts, pct_counts_mt.
    default: violin_plot total_counts n_genes_by_counts pct_counts_mt
    inputBinding:
      position: 104
      prefix: --qc_display
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkatlas:0.7.1--pyhdfd78af_0
stdout: checkatlas.out
