cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_position
label: odgi_position
doc: "Find, translate, and liftover graph and path positions between graphs. Results
  are printed to stdout.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: all_immediate
    type:
      - 'null'
      - boolean
    doc: Emit all positions immediately at the given graph/path position.
    inputBinding:
      position: 101
      prefix: --all-immediate
  - id: all_positions
    type:
      - 'null'
      - boolean
    doc: Emit all positions for all nodes in the specified ref-paths.
    inputBinding:
      position: 101
      prefix: --all-positions
  - id: bed_input
    type:
      - 'null'
      - File
    doc: A BED file of ranges in paths in the graph to lift into the target 
      graph *-v, --give-graph-pos* emit graph positions.
    inputBinding:
      position: 101
      prefix: --bed-input
  - id: gff_input
    type:
      - 'null'
      - File
    doc: A GFF/GTF file with annotation of ranges in paths in the graph to lift 
      into the target (sub)graph emitting graph identifiers with annotation. The
      output is a CSV reading for the visualization within Bandage. The first 
      column is the node identifier, the second column the annotation. If 
      several annotations exist for the same node, they are combined via ';'.
    inputBinding:
      position: 101
      prefix: --gff-input
  - id: give_graph_pos
    type:
      - 'null'
      - boolean
    doc: Emit graph positions (node, offset, strand) rather than path positions.
    inputBinding:
      position: 101
      prefix: --give-graph-pos
  - id: graph_pos
    type:
      - 'null'
      - type: array
        items: string
    doc: A graph position, e.g. 42,10,+ or 302,0,-.
    inputBinding:
      position: 101
      prefix: --graph-pos
  - id: graph_pos_file
    type:
      - 'null'
      - File
    doc: Same as in *-g, --graph-pos*, but for all graph positions in *FILE*.
    inputBinding:
      position: 101
      prefix: --graph-pos-file
  - id: jaccard_context
    type:
      - 'null'
      - int
    doc: 'Maximum walking distance in nucleotides for one orientation when finding
      the best target (reference) range for each query path (default: 10000). Note:
      If we walked 9999 base pairs and **w, --jaccard-context** is **10000**, we will
      also include the next node, even if we overflow the actual limit.'
    default: 10000
    inputBinding:
      position: 101
      prefix: --jaccard-context
  - id: lift_path
    type:
      - 'null'
      - string
    doc: 'Lift positions from *-x, --source* to *-i, --target* via coordinates in
      this path common to both graphs (default: all common paths between *-x, --source*
      and *-i, --target*).'
    inputBinding:
      position: 101
      prefix: --lift-path
  - id: lift_paths_file
    type:
      - 'null'
      - File
    doc: Same as in *-l, --lift-paths*, but for all paths in *FILE*.
    inputBinding:
      position: 101
      prefix: --lift-paths
  - id: path_pos
    type:
      - 'null'
      - type: array
        items: string
    doc: A path position, e.g. chr8,1337,+ or chrZ,3929,-.
    inputBinding:
      position: 101
      prefix: --path-pos
  - id: path_pos_file
    type:
      - 'null'
      - File
    doc: A *FILE* with one path position per line.
    inputBinding:
      position: 101
      prefix: --path-pos-file
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: ref_path
    type:
      - 'null'
      - string
    doc: Translate the given positions into positions relative to this reference
      path.
    inputBinding:
      position: 101
      prefix: --ref-path
  - id: ref_paths_file
    type:
      - 'null'
      - File
    doc: Use the ref-paths in *FILE* for positional translation.
    inputBinding:
      position: 101
      prefix: --ref-paths
  - id: search_radius
    type:
      - 'null'
      - int
    doc: 'Limit coordinate conversion breadth-first search up to DISTANCE bp from
      each given position (default: 10000).'
    default: 10000
    inputBinding:
      position: 101
      prefix: --search-radius
  - id: source_graph
    type:
      - 'null'
      - File
    doc: 'Translate positions from this *FILE graph into the target graph using common
      *-l, --lift-paths* shared between both graphs (default: use the same source/target
      graph). It also accepts GFAv1, but the on-the-fly conversion to the ODGI format
      requires additional time!'
    inputBinding:
      position: 101
      prefix: --source
  - id: target_graph
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_position.out
