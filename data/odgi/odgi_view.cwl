cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi view
label: odgi_view
doc: "Project a graph into other formats.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: display
    type:
      - 'null'
      - boolean
    doc: Show the internal structures of a graph. Print to stderr the maximum 
      node identifier, the minimum node identifier, the nodes vector, the delete
      nodes bit vector and the path metadata, each in a separate line.
    inputBinding:
      position: 101
      prefix: --display
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: node_annotation
    type:
      - 'null'
      - boolean
    doc: Emit node annotations for the graph in GFAv1 format.
    inputBinding:
      position: 101
      prefix: --node-annotation
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
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
  - id: to_gfa
    type:
      - 'null'
      - boolean
    doc: Write the graph in GFAv1 format to standard output.
    inputBinding:
      position: 101
      prefix: --to-gfa
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_view.out
