cwlVersion: v1.2
class: CommandLineTool
baseCommand: genclust
label: genclust
doc: "Performs gene clustering.\n\nTool homepage: http://www.math.unipa.it/~lobosco/genclust/"
inputs:
  - id: file_input
    type: File
    doc: Input file containing gene data.
    inputBinding:
      position: 1
  - id: ncluster
    type: int
    doc: Number of clusters to generate.
    inputBinding:
      position: 2
  - id: ngenerations
    type: int
    doc: Number of generations for the clustering algorithm.
    inputBinding:
      position: 3
  - id: random_init
    type: boolean
    doc: Whether to use random initialization for clusters (e.g., 'true' or 
      'false').
    inputBinding:
      position: 4
  - id: output_type
    type: string
    doc: Type of output format (e.g., 'txt', 'csv').
    inputBinding:
      position: 5
outputs:
  - id: fileoutput
    type: File
    doc: Output file for the clustering results.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genclust:1.0--h470a237_0
