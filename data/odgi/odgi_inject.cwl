cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi inject
label: odgi_inject
doc: "Inject BED interval ranges as paths in the graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_targets
    type:
      - 'null'
      - File
    doc: BED file over path space of the graph. Records will be converted into 
      new paths in the output graph.
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
  - id: out
    type: File
    doc: Write the sorted dynamic succinct variation graph to this file. A file 
      ending with *.og* is recommended.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
