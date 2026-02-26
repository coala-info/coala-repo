cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi procbed
label: odgi_procbed
doc: "Intersect and adjust BED interval into PanSN-defined path subranges. Lift BED
  files into graphs produced by odgi extract. Uses path range information in the path
  names.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_targets
    type:
      - 'null'
      - File
    doc: BED file over path space of the full graph from which this subgraph was
      obtained. Using path range information in the path names, overlapping 
      records will be rewritten to fit into the coordinate space of the 
      subgraph.
    inputBinding:
      position: 101
      prefix: --bed-targets
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_procbed.out
