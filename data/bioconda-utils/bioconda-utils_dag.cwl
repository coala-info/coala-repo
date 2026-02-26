cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - dag
label: bioconda-utils_dag
doc: "Export the DAG of packages to a graph format file for visualization\n\nTool
  homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: 'Path to folder containing recipes (default: recipes/)'
    default: recipes/
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: 'Path to Bioconda config (default: config.yml)'
    default: config.yml
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: Set format to print graph. "gml" and "dot" can be imported into graph 
      visualization tools (graphviz, gephi, cytoscape). "txt" will print out 
      recipes grouped by independent subdags, largest subdag first, each in 
      topologically sorted order. Singleton subdags (if not hidden with 
      --hide-singletons) are reported as one large group at the end.
    default: gml
    inputBinding:
      position: 103
      prefix: --format
  - id: hide_singletons
    type:
      - 'null'
      - boolean
    doc: Hide singletons in the printed graph.
    default: false
    inputBinding:
      position: 103
      prefix: --hide-singletons
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    default: '-'
    inputBinding:
      position: 103
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write log to file
    default: '-'
    inputBinding:
      position: 103
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    default: debug
    inputBinding:
      position: 103
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    default: info
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Glob for package[s] to show in DAG. Default is to show all packages. 
      Can be specified more than once
    default: '*'
    inputBinding:
      position: 103
      prefix: --packages
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_dag.out
