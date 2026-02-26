cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_cover
label: odgi_cover
doc: "Cover the graph with paths.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: hogwild_depth
    type:
      - 'null'
      - int
    doc: Randomly cover the graph until it reaches the given average DEPTH. 
      Specifying this option overwrites all other cover options except -I, 
      --ignore-paths!
    inputBinding:
      position: 101
      prefix: --hogwild-depth
  - id: ignore_paths
    type:
      - 'null'
      - boolean
    doc: Ignore the paths already embedded in the graph during the node depth 
      initialization.
    inputBinding:
      position: 101
      prefix: --ignore-paths
  - id: input_graph
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: min_node_depth
    type:
      - 'null'
      - int
    doc: Minimum node depth to reach (it has to be greater than 0). There will 
      be generated paths until the specified minimum node coverage is reached, 
      or until the maximum number of allowed generated paths is reached (number 
      of nodes in the input ODGI graph).
    inputBinding:
      position: 101
      prefix: --min-node-depth
  - id: node_window_size
    type:
      - 'null'
      - int
    doc: Size of the node window to check each time a new path is extended (it 
      has to be greater than or equal to 2).
    inputBinding:
      position: 101
      prefix: --node-window-size
  - id: num_paths_per_component
    type:
      - 'null'
      - int
    doc: Number of paths to generate per component.
    inputBinding:
      position: 101
      prefix: --num-paths-per-component
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Print information about the components and the progress to stderr
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_graph
    type: File
    doc: Write the succinct variation graph with the generated paths in ODGI 
      format to *FILE*. A file ending with *.og* is recommended.
    outputBinding:
      glob: $(inputs.output_graph)
  - id: write_node_depth
    type:
      - 'null'
      - File
    doc: 'Write the node depth at the end of the paths generation to FILE. The file
      will contain tab-separated values (header included), and have 3 columns: component_id,
      node_ide, coverage.'
    outputBinding:
      glob: $(inputs.write_node_depth)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
