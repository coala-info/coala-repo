cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - plot_clusters
label: cblaster_plot_clusters
doc: "Plot clusters using clinker\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: session
    type: File
    doc: cblaster session file
    inputBinding:
      position: 1
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: Cluster numbers/ ranges provided by the summary file of the 'search' 
      command.
    inputBinding:
      position: 102
      prefix: --clusters
  - id: maximum_clusters
    type:
      - 'null'
      - int
    doc: The maximum amount of clusters that will be plotted. Ordered on score 
      (def. 50)
    inputBinding:
      position: 102
      prefix: --maximum_clusters
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organism names
    inputBinding:
      position: 102
      prefix: --organisms
  - id: scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffold names/ranges
    inputBinding:
      position: 102
      prefix: --scaffolds
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Minimum score of a cluster to be included
    inputBinding:
      position: 102
      prefix: --score_threshold
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Location were to store the plot file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
