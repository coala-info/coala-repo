cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph_gtfs.pl
label: eval_graph_gtfs.pl
doc: "Takes a graph file, an annotation and one or more predictions and prints each graph specified by the graph file for each prediction as text.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: list_member_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the list files (staged beside the lists so the names resolve); not used with -g"
  - id: list_graph_options
    type:
      - 'null'
      - boolean
    doc: "Display list of possible x and y values for graphs"
    inputBinding:
      position: 1
      prefix: -G
  - id: gtf_input
    type:
      - 'null'
      - boolean
    doc: "Load GTFs instead of lists of GTFs"
    inputBinding:
      position: 2
      prefix: -g
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: "Quick load the gtf file. Do not check them for errors."
    inputBinding:
      position: 3
      prefix: -q
  - id: resolution_file
    type:
      - 'null'
      - File
    doc: "Load resolution from this file instead of the user .eval.rc or default"
    inputBinding:
      position: 4
      prefix: -r
  - id: graph_file
    type: File
    doc: "Graph file; each line is \"y_level::y_type::y_stat vs x_type::x_level\""
    inputBinding:
      position: 100
  - id: annotation
    type: File
    doc: "Annotation GTF (or list file)"
    inputBinding:
      position: 101
  - id: predictions
    type:
      type: array
      items: File
    doc: "Prediction GTFs (or list files); one or more"
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Graph tables
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_member_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_graph_gtfs.pl.out
