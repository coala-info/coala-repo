cwlVersion: v1.2
class: CommandLineTool
baseCommand: hcluster_pangenome_matrix.sh
label: get_homologues_hcluster_pangenome_matrix.sh
doc: "Computes a distance matrix from a pangenome_matrix.tab file produced by get_homologues.pl and compare_clusters.pl (options -t 0 -m), clusters it with hclust() and plots a heatmap with heatmap.2(), with goodness of clustering statistics (gap or silhouette width).\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: input_matrix
    type: File
    doc: name of matrix file (pangenome_matrix_t0.tab)
    inputBinding:
      position: 1
      prefix: -i
  - id: clustering_algorithm
    type:
      - 'null'
      - string
    doc: algorithm/method for clustering [ward.D|ward.D2|single|complete|average(=UPGMA)] (def - ward.D2)
    inputBinding:
      position: 1
      prefix: -a
  - id: distance_type
    type:
      - 'null'
      - string
    doc: distance type [euclidean|manhattan|gower] (def - gower)
    inputBinding:
      position: 1
      prefix: -d
  - id: goodness_statistic
    type:
      - 'null'
      - string
    doc: goodness of clustering statistic [gap|sil] (def - sil)
    inputBinding:
      position: 1
      prefix: -s
  - id: gap_random_starts
    type:
      - 'null'
      - int
    doc: number of random starts (gap statistic) (def - 25)
    inputBinding:
      position: 1
      prefix: -S
  - id: gap_method
    type:
      - 'null'
      - string
    doc: gap statistic method - [firstSEmax|Tibs2001SEmax|globalSEmax|firstmax|globalmax] (def - Tibs2001SEmax)
    inputBinding:
      position: 1
      prefix: -m
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: number of bootstrap replicates (gap stat.) (def - 100)
    inputBinding:
      position: 1
      prefix: -n
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: max. number of clusters (def - 15; NOTE - 2<= k <= n-1)
    inputBinding:
      position: 1
      prefix: -k
  - id: display_distances
    type:
      - 'null'
      - int
    doc: 1|0 to display or not the distance values in the heatmap cells (def - 0)
    inputBinding:
      position: 1
      prefix: -c
  - id: max_decimals
    type:
      - 'null'
      - int
    doc: maximum number of decimals in matrix display [1,2; def - 2]
    inputBinding:
      position: 1
      prefix: -F
  - id: main_title
    type:
      - 'null'
      - string
    doc: text for Main title (def - Pan-genome tree)
    inputBinding:
      position: 1
      prefix: -T
  - id: margins_horizontal
    type:
      - 'null'
      - int
    doc: margins_horizontal (def - 20)
    inputBinding:
      position: 1
      prefix: -M
  - id: margins_vertical
    type:
      - 'null'
      - int
    doc: margins_vertical (def - 21)
    inputBinding:
      position: 1
      prefix: -V
  - id: output_format
    type:
      - 'null'
      - string
    doc: output file format [svg|pdf] (def - pdf)
    inputBinding:
      position: 1
      prefix: -O
  - id: device_points
    type:
      - 'null'
      - int
    doc: points for plotting device (def - 15)
    inputBinding:
      position: 1
      prefix: -P
  - id: device_height
    type:
      - 'null'
      - int
    doc: output device height (def - 15)
    inputBinding:
      position: 1
      prefix: -H
  - id: device_width
    type:
      - 'null'
      - int
    doc: output device width (def - 17)
    inputBinding:
      position: 1
      prefix: -W
  - id: label_angles
    type:
      - 'null'
      - string
    doc: angle to rotate row,col labels, as 'integer,integer' (def - NULL,NULL)
    inputBinding:
      position: 1
      prefix: -A
  - id: label_expansion
    type:
      - 'null'
      - float
    doc: leaf label character expansion factor (def - 0.7)
    inputBinding:
      position: 1
      prefix: -X
  - id: filter_regex
    type:
      - 'null'
      - string
    doc: filter input pangenome_matrix_t0.tab using a regular expression, like 'Escherichia|Salmonella'
    inputBinding:
      position: 1
      prefix: -x
outputs:
  - id: newick_tree
    type:
      - 'null'
      - File
    doc: Newick tree of the hierarchical clustering (.ph).
    outputBinding:
      glob: '*.ph'
  - id: distance_matrix
    type:
      - 'null'
      - File
    doc: Distance matrix computed from the pangenome matrix.
    outputBinding:
      glob: '*_dist_matrix.tab'
  - id: plots
    type:
      type: array
      items: File
    doc: Tree, heatmap and goodness of clustering plots (pdf or svg).
    outputBinding:
      glob:
        - '*.pdf'
        - '*.svg'
  - id: r_script
    type:
      - 'null'
      - File
    doc: R script written by the run.
    outputBinding:
      glob: hcluster_pangenome_matrix_script_run_at_*.R
  - id: stdout
    type: stdout
    doc: Standard output
stdout: get_homologues_hcluster_pangenome_matrix.sh.out
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_matrix)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
