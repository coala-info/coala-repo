cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_matrix_heatmap.sh
label: get_homologues_plot_matrix_heatmap.sh
doc: "Plots ordered heatmaps with row and column dendrograms from a squared numeric (distance or presence-absence) matrix, like the *Avg_identity.tab matrices produced by get_homologues.pl with the -A flag.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: input_matrix
    type: File
    doc: '*Avg_identity.tab file'
    inputBinding:
      position: 1
      prefix: -i
  - id: identity_cutoff
    type:
      - 'null'
      - float
    doc: (maximum) identity cut-off value to filter out excessive redundancy (e.g. 97.3) (def - 100)
    inputBinding:
      position: 1
      prefix: -c
  - id: max_decimals
    type:
      - 'null'
      - int
    doc: maximum number of decimals in matrix display [0-2] (def - 0)
    inputBinding:
      position: 1
      prefix: -d
  - id: node_angle
    type:
      - 'null'
      - int
    doc: angle to rotate node angles (def - 45)
    inputBinding:
      position: 1
      prefix: -a
  - id: plot_title
    type:
      - 'null'
      - string
    doc: text for plot title (def - input_tab_file_name)
    inputBinding:
      position: 1
      prefix: -t
  - id: margins_horizontal
    type:
      - 'null'
      - int
    doc: margins_horizontal (def - 18)
    inputBinding:
      position: 1
      prefix: -m
  - id: margins_vertical
    type:
      - 'null'
      - int
    doc: margins_vertical (def - 18)
    inputBinding:
      position: 1
      prefix: -v
  - id: output_format
    type:
      - 'null'
      - string
    doc: output file format (def - svg)
    inputBinding:
      position: 1
      prefix: -o
  - id: device_points
    type:
      - 'null'
      - int
    doc: points for plotting device (def - 15)
    inputBinding:
      position: 1
      prefix: -p
  - id: device_height
    type:
      - 'null'
      - int
    doc: output device height (def - 10)
    inputBinding:
      position: 1
      prefix: -H
  - id: device_width
    type:
      - 'null'
      - int
    doc: output device width (def - 15)
    inputBinding:
      position: 1
      prefix: -W
  - id: no_reorder
    type:
      - 'null'
      - boolean
    doc: do not reorder clusters (def - reorder clusters and plot dendrogram)
    inputBinding:
      position: 1
      prefix: -C
  - id: remove_names
    type:
      - 'null'
      - boolean
    doc: remove column names and cell contents (def - names and cell contents are printed)
    inputBinding:
      position: 1
      prefix: -r
  - id: scale_label
    type:
      - 'null'
      - string
    doc: text for scale X-axis (def - Value)
    inputBinding:
      position: 1
      prefix: -k
  - id: right_border
    type:
      - 'null'
      - int
    doc: right border (margin) in dendrograms (def - 10)
    inputBinding:
      position: 1
      prefix: -b
  - id: char_expansion
    type:
      - 'null'
      - float
    doc: character expansion factor (def - 1.0)
    inputBinding:
      position: 1
      prefix: -X
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: max. number of clusters, 2 <= K <= n-1
    inputBinding:
      position: 1
      prefix: -K
  - id: nj_analysis
    type:
      - 'null'
      - boolean
    doc: compute a distance matrix (ANdist) from the input similarity matrix and use it to construct a NJ tree saved as newick, plus a complete linkage dendrogram with cutoffs at ANdist 6, 5 and 4 (ANI 94%, 95% and 96%); do not use with a binary presence-absence matrix
    inputBinding:
      position: 1
      prefix: -N
  - id: filter_regex
    type:
      - 'null'
      - string
    doc: subset the matrix with a regular expression, like 'species1|species2'
    inputBinding:
      position: 1
      prefix: -x
outputs:
  - id: plots
    type:
      type: array
      items: File
    doc: Heatmap and goodness of clustering plots (svg or pdf).
    outputBinding:
      glob:
        - '*.svg'
        - '*.pdf'
  - id: newick_tree
    type:
      - 'null'
      - File
    doc: Neighbour-joining tree as newick string (written with the NJ analysis).
    outputBinding:
      glob: '*.ph'
  - id: r_script
    type:
      - 'null'
      - File
    doc: R script written by the run.
    outputBinding:
      glob: plot_matrix_heatmap_script_run_at_*.R
  - id: stdout
    type: stdout
    doc: Standard output
stdout: get_homologues_plot_matrix_heatmap.sh.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
