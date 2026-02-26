cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi degree
label: odgi_degree
doc: "Describe the graph in terms of node degree.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_input_file
    type:
      - 'null'
      - File
    doc: A BED file of ranges in paths in the graph.
    inputBinding:
      position: 101
      prefix: --bed-input
  - id: graph_degree_table
    type:
      - 'null'
      - boolean
    doc: 'Compute the degree on each node in the graph, writing a table by node: node.id,
      degree.'
    inputBinding:
      position: 101
      prefix: --graph-degree-table
  - id: graph_degree_vec
    type:
      - 'null'
      - boolean
    doc: Compute the degree on each node in the graph, writing a vector by base 
      in one line.
    inputBinding:
      position: 101
      prefix: --graph-degree-vec
  - id: graph_pos
    type:
      - 'null'
      - string
    doc: Compute the degree at the given node, e.g. 7 or 3,4 or 42,10,+ or 
      302,0,-.
    inputBinding:
      position: 101
      prefix: --graph-pos
  - id: graph_pos_file
    type:
      - 'null'
      - File
    doc: A file with one graph position per line.
    inputBinding:
      position: 101
      prefix: --graph-pos-file
  - id: input_file
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --input
  - id: path_degree
    type:
      - 'null'
      - boolean
    doc: Compute a vector of degree on each base of each path. Each line 
      consists of a path name and subsequently the space-separated degree of 
      each base.
    inputBinding:
      position: 101
      prefix: --path-degree
  - id: path_name
    type:
      - 'null'
      - string
    doc: Compute the degree of the given path PATH_NAME in the graph.
    inputBinding:
      position: 101
      prefix: --path
  - id: path_pos
    type:
      - 'null'
      - string
    doc: Return degree at the given path position e.g. chrQ or chr3,42 or 
      chr8,1337,+ or chrZ,3929,-.
    inputBinding:
      position: 101
      prefix: --path-pos
  - id: path_pos_file
    type:
      - 'null'
      - File
    doc: A file with one path position per line.
    inputBinding:
      position: 101
      prefix: --path-pos-file
  - id: paths_file
    type:
      - 'null'
      - File
    doc: Report the degree only for the paths listed in FILE.
    inputBinding:
      position: 101
      prefix: --paths
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: self_degree
    type:
      - 'null'
      - boolean
    doc: Compute the degree of the path versus itself on each base in each path.
      Each line consists of a path name and subsequently the space-separated 
      degree of each base.
    inputBinding:
      position: 101
      prefix: --self-degree
  - id: subset_paths_file
    type:
      - 'null'
      - File
    doc: Compute the degree considering only the paths specified in the FILE. 
      The file must contain one path name per line and a subset of all paths can
      be specified; If a step is of a path of the given list, it is taken into 
      account when calculating a node's degree. Else not.
    inputBinding:
      position: 101
      prefix: --subset-paths
  - id: summarize_graph_degree
    type:
      - 'null'
      - boolean
    doc: Summarize the graph properties and dimensions. Print in tab-delimited 
      format to stdout the node.count, edge.count, avg.degree, min.degree, 
      max.degree.
    inputBinding:
      position: 101
      prefix: --summarize-graph-degree
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: windows_in
    type:
      - 'null'
      - string
    doc: Print to stdout a BED file of path intervals where the degree is 
      between MIN and MAX, merging regions not separated by more than LEN bp.
    inputBinding:
      position: 101
      prefix: --windows-in
  - id: windows_out
    type:
      - 'null'
      - string
    doc: Print to stdout a BED file of path intervals where the degree is 
      outside of MIN and MAX, merging regions not separated by more than LEN bp.
    inputBinding:
      position: 101
      prefix: --windows-out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_degree.out
