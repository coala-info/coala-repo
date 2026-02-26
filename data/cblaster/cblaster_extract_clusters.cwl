cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - extract_clusters
label: cblaster_extract_clusters
doc: "Extract clusters from a session file\n\nTool homepage: https://github.com/gamcil/cblaster"
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
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the resulting files. The options are genbank and bigscape
    inputBinding:
      position: 102
      prefix: --format
  - id: maximum_clusters
    type:
      - 'null'
      - int
    doc: The maximum amount of clusters that will be extracted. Ordered on score
      (def. 50)
    default: 50
    inputBinding:
      position: 102
      prefix: --maximum_clusters
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organism names (can be regex patterns)
    inputBinding:
      position: 102
      prefix: --organisms
  - id: prefix
    type:
      - 'null'
      - string
    doc: Start of the name for each cluster file, the base name is 
      'cluster_clutser_number' e.g. cluster1
    inputBinding:
      position: 102
      prefix: --prefix
  - id: scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffold names/ranges e.g name:start-stop. Only clusters fully within 
      the range are selected.
    inputBinding:
      position: 102
      prefix: --scaffolds
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Minimum score of a cluster in order to be included
    inputBinding:
      position: 102
      prefix: --score_threshold
outputs:
  - id: output
    type: Directory
    doc: Output directory for the clusters
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
