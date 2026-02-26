cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool womgraph
label: wdltool_womgraph
doc: "Generate a DOT graph of a WDL workflow or CWL document.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: input_file
    type: File
    doc: The WDL workflow or CWL document to graph.
    inputBinding:
      position: 1
  - id: color_scheme
    type:
      - 'null'
      - string
    doc: Specify a color scheme for the graph.
    inputBinding:
      position: 102
      prefix: --color-scheme
  - id: engine_options
    type:
      - 'null'
      - string
    doc: JSON string of Cromwell engine options to use when parsing WDL.
    inputBinding:
      position: 102
      prefix: --engine-options
  - id: engine_version
    type:
      - 'null'
      - string
    doc: Specify the version of the WDL engine to use for parsing.
    inputBinding:
      position: 102
      prefix: --engine-version
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: JSON file(s) containing workflow inputs. Can be specified multiple 
      times.
    inputBinding:
      position: 102
      prefix: --inputs
  - id: layout
    type:
      - 'null'
      - string
    doc: Graphviz layout engine to use (e.g., dot, neato, fdp, sfdp, twopi, 
      circo). Defaults to 'dot'.
    default: dot
    inputBinding:
      position: 102
      prefix: --layout
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable coloring of graph elements.
    inputBinding:
      position: 102
      prefix: --no-color
  - id: show_all_details
    type:
      - 'null'
      - boolean
    doc: Show all available details in the graph.
    inputBinding:
      position: 102
      prefix: --show-all-details
  - id: show_all_nodes
    type:
      - 'null'
      - boolean
    doc: Show all nodes in the graph, including those not directly connected to 
      the main workflow.
    inputBinding:
      position: 102
      prefix: --show-all-nodes
  - id: show_all_variables
    type:
      - 'null'
      - boolean
    doc: Show all variables in the graph.
    inputBinding:
      position: 102
      prefix: --show-all-variables
  - id: show_call_level_inputs
    type:
      - 'null'
      - boolean
    doc: Show inputs at the call level in the graph.
    inputBinding:
      position: 102
      prefix: --show-call-level-inputs
  - id: show_call_level_outputs
    type:
      - 'null'
      - boolean
    doc: Show outputs at the call level in the graph.
    inputBinding:
      position: 102
      prefix: --show-call-level-outputs
  - id: show_calls
    type:
      - 'null'
      - boolean
    doc: Include workflow calls in the graph.
    inputBinding:
      position: 102
      prefix: --show-calls
  - id: show_cluster_attributes
    type:
      - 'null'
      - boolean
    doc: Show attributes of clusters in the graph.
    inputBinding:
      position: 102
      prefix: --show-cluster-attributes
  - id: show_command_line
    type:
      - 'null'
      - boolean
    doc: Show the command line for tasks in the graph.
    inputBinding:
      position: 102
      prefix: --show-command-line
  - id: show_comment_attributes
    type:
      - 'null'
      - boolean
    doc: Show attributes of comment nodes/edges in the graph.
    inputBinding:
      position: 102
      prefix: --show-comment-attributes
  - id: show_comment_edges
    type:
      - 'null'
      - boolean
    doc: Show comment edges in the graph.
    inputBinding:
      position: 102
      prefix: --show-comment-edges
  - id: show_comment_nodes
    type:
      - 'null'
      - boolean
    doc: Show comment nodes in the graph.
    inputBinding:
      position: 102
      prefix: --show-comment-nodes
  - id: show_conditional_variables
    type:
      - 'null'
      - boolean
    doc: Show variables involved in conditional operations in the graph.
    inputBinding:
      position: 102
      prefix: --show-conditional-variables
  - id: show_container_images
    type:
      - 'null'
      - boolean
    doc: Show container images used by tasks in the graph.
    inputBinding:
      position: 102
      prefix: --show-container-images
  - id: show_dependencies
    type:
      - 'null'
      - boolean
    doc: Show dependencies between tasks and calls in the graph.
    inputBinding:
      position: 102
      prefix: --show-dependencies
  - id: show_docker_images
    type:
      - 'null'
      - boolean
    doc: Show Docker images used by tasks in the graph.
    inputBinding:
      position: 102
      prefix: --show-docker-images
  - id: show_edge_attributes
    type:
      - 'null'
      - boolean
    doc: Show attributes of edges in the graph.
    inputBinding:
      position: 102
      prefix: --show-edge-attributes
  - id: show_edge_descriptions
    type:
      - 'null'
      - boolean
    doc: Show descriptions on edges in the graph.
    inputBinding:
      position: 102
      prefix: --show-edge-descriptions
  - id: show_edge_labels
    type:
      - 'null'
      - boolean
    doc: Show labels on edges in the graph.
    inputBinding:
      position: 102
      prefix: --show-edge-labels
  - id: show_fold
    type:
      - 'null'
      - boolean
    doc: Show fold operations in the graph.
    inputBinding:
      position: 102
      prefix: --show-fold
  - id: show_fold_variables
    type:
      - 'null'
      - boolean
    doc: Show variables involved in fold operations in the graph.
    inputBinding:
      position: 102
      prefix: --show-fold-variables
  - id: show_graph_attributes
    type:
      - 'null'
      - boolean
    doc: Show attributes of the graph itself.
    inputBinding:
      position: 102
      prefix: --show-graph-attributes
  - id: show_hidden_nodes
    type:
      - 'null'
      - boolean
    doc: Show hidden nodes in the graph.
    inputBinding:
      position: 102
      prefix: --show-hidden-nodes
  - id: show_if
    type:
      - 'null'
      - boolean
    doc: Show conditional operations in the graph.
    inputBinding:
      position: 102
      prefix: --show-if
  - id: show_inputs
    type:
      - 'null'
      - boolean
    doc: Include workflow inputs in the graph.
    inputBinding:
      position: 102
      prefix: --show-inputs
  - id: show_intermediate_variables
    type:
      - 'null'
      - boolean
    doc: Show intermediate variables in the graph.
    inputBinding:
      position: 102
      prefix: --show-intermediate-variables
  - id: show_labels
    type:
      - 'null'
      - boolean
    doc: Show labels associated with tasks and calls in the graph.
    inputBinding:
      position: 102
      prefix: --show-labels
  - id: show_meta_variables
    type:
      - 'null'
      - boolean
    doc: Show meta variables in the graph.
    inputBinding:
      position: 102
      prefix: --show-meta-variables
  - id: show_node_attributes
    type:
      - 'null'
      - boolean
    doc: Show attributes of nodes in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-attributes
  - id: show_node_connections
    type:
      - 'null'
      - boolean
    doc: Show connections between nodes in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-connections
  - id: show_node_descriptions
    type:
      - 'null'
      - boolean
    doc: Show node descriptions in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-descriptions
  - id: show_node_groups
    type:
      - 'null'
      - boolean
    doc: Show groups of nodes in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-groups
  - id: show_node_ids
    type:
      - 'null'
      - boolean
    doc: Show node IDs in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-ids
  - id: show_node_labels
    type:
      - 'null'
      - boolean
    doc: Show node labels in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-labels
  - id: show_node_ports
    type:
      - 'null'
      - boolean
    doc: Show node ports in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-ports
  - id: show_node_types
    type:
      - 'null'
      - boolean
    doc: Show node types in the graph.
    inputBinding:
      position: 102
      prefix: --show-node-types
  - id: show_outputs
    type:
      - 'null'
      - boolean
    doc: Include workflow outputs in the graph.
    inputBinding:
      position: 102
      prefix: --show-outputs
  - id: show_parameter_expressions
    type:
      - 'null'
      - boolean
    doc: Show parameter expressions in the graph.
    inputBinding:
      position: 102
      prefix: --show-parameter-expressions
  - id: show_runtime_attributes
    type:
      - 'null'
      - boolean
    doc: Show runtime attributes in the graph.
    inputBinding:
      position: 102
      prefix: --show-runtime-attributes
  - id: show_scatter
    type:
      - 'null'
      - boolean
    doc: Show scatter operations in the graph.
    inputBinding:
      position: 102
      prefix: --show-scatter
  - id: show_scatter_variables
    type:
      - 'null'
      - boolean
    doc: Show variables involved in scatter operations in the graph.
    inputBinding:
      position: 102
      prefix: --show-scatter-variables
  - id: show_string_interpolation
    type:
      - 'null'
      - boolean
    doc: Show string interpolation in the graph.
    inputBinding:
      position: 102
      prefix: --show-string-interpolation
  - id: show_string_interpolation_variables
    type:
      - 'null'
      - boolean
    doc: Show variables involved in string interpolation in the graph.
    inputBinding:
      position: 102
      prefix: --show-string-interpolation-variables
  - id: show_subgraph_attributes
    type:
      - 'null'
      - boolean
    doc: Show attributes of subgraphs in the graph.
    inputBinding:
      position: 102
      prefix: --show-subgraph-attributes
  - id: show_task_inputs
    type:
      - 'null'
      - boolean
    doc: Show task inputs in the graph.
    inputBinding:
      position: 102
      prefix: --show-task-inputs
  - id: show_task_level_inputs
    type:
      - 'null'
      - boolean
    doc: Show inputs at the task level in the graph.
    inputBinding:
      position: 102
      prefix: --show-task-level-inputs
  - id: show_task_level_outputs
    type:
      - 'null'
      - boolean
    doc: Show outputs at the task level in the graph.
    inputBinding:
      position: 102
      prefix: --show-task-level-outputs
  - id: show_task_outputs
    type:
      - 'null'
      - boolean
    doc: Show task outputs in the graph.
    inputBinding:
      position: 102
      prefix: --show-task-outputs
  - id: show_workflow_inputs
    type:
      - 'null'
      - boolean
    doc: Show workflow inputs in the graph.
    inputBinding:
      position: 102
      prefix: --show-workflow-inputs
  - id: show_workflow_level_inputs
    type:
      - 'null'
      - boolean
    doc: Show inputs at the workflow level in the graph.
    inputBinding:
      position: 102
      prefix: --show-workflow-level-inputs
  - id: show_workflow_level_outputs
    type:
      - 'null'
      - boolean
    doc: Show outputs at the workflow level in the graph.
    inputBinding:
      position: 102
      prefix: --show-workflow-level-outputs
  - id: show_workflow_outputs
    type:
      - 'null'
      - boolean
    doc: Show workflow outputs in the graph.
    inputBinding:
      position: 102
      prefix: --show-workflow-outputs
  - id: type
    type:
      - 'null'
      - string
    doc: The type of input file ('wdl' or 'cwl'). Defaults to 'wdl'.
    default: wdl
    inputBinding:
      position: 102
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The file to write the DOT graph to. Defaults to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
