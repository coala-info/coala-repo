cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_depth
label: odgi_depth
doc: "Find the depth of a graph as defined by query criteria. Without specifying any
  non-mandatory options, it prints in a tab-delimited format path, start, end, and
  mean.depth to stdout.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_input_file
    type:
      - 'null'
      - File
    doc: A BED file of ranges in paths in the graph.
    inputBinding:
      position: 101
      prefix: --bed-input
  - id: graph_depth_table
    type:
      - 'null'
      - boolean
    doc: 'Compute the depth and unique depth on each node in the graph, writing a
      table by node: node.id, depth, depth.uniq.'
    inputBinding:
      position: 101
      prefix: --graph-depth-table
  - id: graph_depth_vec
    type:
      - 'null'
      - boolean
    doc: Compute the depth on each node in the graph, writing a vector by base 
      in one line.
    inputBinding:
      position: 101
      prefix: --graph-depth-vec
  - id: graph_pos
    type:
      - 'null'
      - string
    doc: Compute the depth at the given node, e.g. 7 or 3,4 or 42,10,+
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
  - id: path_depth
    type:
      - 'null'
      - boolean
    doc: Compute a vector of depth on each base of each path. Each line consists
      of a path name and subsequently the space-separated depth of each base.
    inputBinding:
      position: 101
      prefix: --path-depth
  - id: path_name
    type:
      - 'null'
      - string
    doc: Compute the depth of the given path PATH_NAME in the graph.
    inputBinding:
      position: 101
      prefix: --path
  - id: path_pos
    type:
      - 'null'
      - string
    doc: Return depth at the given path position e.g. chrQ or chr3,42 or 
      chr8,1337,+
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
    doc: Report the depth only for the paths listed in FILE.
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
  - id: self_depth
    type:
      - 'null'
      - boolean
    doc: Compute the depth of the path versus itself on each base in each path. 
      Each line consists of a path name and subsequently the space-separated 
      depth of each base.
    inputBinding:
      position: 101
      prefix: --self-depth
  - id: subset_paths_file
    type:
      - 'null'
      - File
    doc: Compute the depth considering only the paths specified in the FILE. The
      file must contain one path name per line and a subset of all paths can be 
      specified; If a step is of a path of the given list, it is taken into 
      account when calculating a node's depth. Else not.
    inputBinding:
      position: 101
      prefix: --subset-paths
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: 'Provide a summary of the depth distribution in the graph, in a tab-delimited
      format it prints to stdout: node.count, graph.length, step.count, path.length,
      mean.node.depth (step.count/node.count), and mean.graph.depth (path.length/graph.length).'
    inputBinding:
      position: 101
      prefix: --summarize
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use in parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_unique_depth
    type:
      - 'null'
      - boolean
    doc: For --window-in and --window-out, count UNIQUE depth, not total node 
      depth
    inputBinding:
      position: 101
      prefix: --window-unique-depth
  - id: windows_in
    type:
      - 'null'
      - string
    doc: Print to stdout a BED file of path intervals where the depth is between
      MIN and MAX, merging regions not separated by more than LEN bp. When 
      TIPS=1, retain only tips.
    inputBinding:
      position: 101
      prefix: --windows-in
  - id: windows_out
    type:
      - 'null'
      - string
    doc: Print to stdout a BED file of path intervals where the depth is outside
      of MIN and MAX, merging regions not separated by more than LEN bp. When 
      TIPS=1, retain only tips.
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
stdout: odgi_depth.out
