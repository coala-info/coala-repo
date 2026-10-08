cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blockclust.py
label: blockclust_blockclust.py_post
doc: "BlockClust post-processing mode (-m POST): annotate clusters with known Rfam
  families from cmsearch output and plot the cluster distribution and the clustering
  of cluster candidates\n\nTool homepage: https://github.com/pavanvidem/blockclust"
arguments:
  - position: 100
    prefix: --mode
    valueFrom: POST
inputs:
  - id: cmsearch_out
    type: File
    doc: Output of cmsearch tool (--tblout table on the cluster sequences, with
      the '#' comment lines removed; the target description must hold the
      cluster BED name)
    inputBinding:
      position: 101
      prefix: --cmsearch_out
  - id: clusters_bed
    type: File
    doc: BED file containing clusters from ANALYSIS mode
    inputBinding:
      position: 101
      prefix: --clust_bed
  - id: sim_tab
    type: File
    doc: Tabular file of pairwise blockgroup similarities
    inputBinding:
      position: 101
      prefix: --sim_tab
  - id: rfam_map
    type:
      - 'null'
      - File
    doc: 'Mapping of Rfam families (default: 
      /usr/local/share/blockclust_data/rfam_map.txt)'
    inputBinding:
      position: 101
      prefix: --rfam_map
  - id: output_dir_path
    type: string
    doc: Output directory path for the whole analysis
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory of the post-processing
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: cluster_distribution
    type: File
    doc: Distribution of RNA types per cluster (cluster_distribution.txt)
    outputBinding:
      glob: $(inputs.output_dir_path)/cluster_distribution.txt
  - id: cluster_distribution_plot
    type:
      - 'null'
      - File
    doc: Cluster distribution plot (cluster_distribution.pdf)
    outputBinding:
      glob: $(inputs.output_dir_path)/cluster_distribution.pdf
  - id: cluster_hclust_plot
    type:
      - 'null'
      - File
    doc: Hierarchical clustering plot of cluster centroids 
      (hclust_tree_clusters.pdf)
    outputBinding:
      glob: $(inputs.output_dir_path)/hclust_tree_clusters.pdf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
