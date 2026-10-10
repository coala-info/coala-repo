cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - learnGraph
label: monocle3-cli_learnGraph
doc: "Learn trajectories.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: input_object
    type: File
    doc: "Input object, CellDataSet V3 (cds3) as an RDS file. Only cds3 is supported currently."
    inputBinding:
      position: 1
  - id: output_object
    type: string
    doc: "Output object file name (cds3 as RDS)."
    inputBinding:
      position: 2
  - id: input_object_format
    type:
      - 'null'
      - string
    doc: "Format of input object. [Default: cds3]"
    inputBinding:
      position: 103
      prefix: -f
  - id: output_object_format
    type:
      - 'null'
      - string
    doc: "Format of output object. [Default: cds3]"
    inputBinding:
      position: 103
      prefix: -F
  - id: introspective
    type:
      - 'null'
      - boolean
    doc: "Print introspective information of the output object."
    inputBinding:
      position: 103
      prefix: -I
  - id: no_partition
    type:
      - 'null'
      - boolean
    doc: "When this option is set, learn a single tree structure for all the partitions. If not set, use the partitions calculated when clustering and identify disjoint graphs in each."
    inputBinding:
      position: 103
      prefix: --no-partition
  - id: no_close_loop
    type:
      - 'null'
      - boolean
    doc: "When this option is set, skip the additional run of loop closing after computing the principal graphs to identify potential loop structure in the data space."
    inputBinding:
      position: 103
      prefix: --no-close-loop
  - id: euclidean_distance_ratio
    type:
      - 'null'
      - float
    doc: "The maximal ratio between the euclidean distance of two tip nodes in the spanning tree inferred from SimplePPT algorithm and that of the maximum distance between any connecting points on the spanning tree allowed to be connected during the loop closure procedure. [Default: 1]"
    inputBinding:
      position: 103
      prefix: --euclidean-distance-ratio
  - id: geodesic_distance_ratio
    type:
      - 'null'
      - float
    doc: "The minimal ratio between the geodestic distance of two tip nodes in the spanning tree inferred from SimplePPT algorithm and that of the length of the diameter path on the spanning tree allowed to be connected during the loop closure procedure. (Both euclidean_distance_ratio and geodestic_distance_ratio need to be satisfied to introduce the edge for loop closure.)"
    inputBinding:
      position: 103
      prefix: --geodesic-distance-ratio
  - id: no_prune_graph
    type:
      - 'null'
      - boolean
    doc: "When this option is set, perform an additional run of graph pruning to remove smaller insignificant branches."
    inputBinding:
      position: 103
      prefix: --no-prune-graph
  - id: minimal_branch_len
    type:
      - 'null'
      - int
    doc: "The minimal length of the diameter path for a branch to be preserved during graph pruning procedure. [Default: 10]"
    inputBinding:
      position: 103
      prefix: --minimal-branch-len
  - id: orthogonal_proj_tip
    type:
      - 'null'
      - boolean
    doc: "When this option is set, perform orthogonal projection for cells corresponding to the tip principal points."
    inputBinding:
      position: 103
      prefix: --orthogonal-proj-tip
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Emit verbose output."
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_object
    type: File
    doc: "Output object"
    outputBinding:
      glob: $(inputs.output_object)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
