cwlVersion: v1.2
class: CommandLineTool
baseCommand: genclust
label: genclust
doc: "GenClust: a genetic algorithm for clustering gene expression data. The input
  file starts with a line holding the number of genes and the number of features,
  then one row per gene (name followed by feature values).\n\nTool homepage: http://www.math.unipa.it/~lobosco/genclust/"
inputs:
  - id: file_input
    type: File
    doc: Input file containing gene expression data.
    inputBinding:
      position: 1
  - id: ncluster
    type: int
    doc: Number of clusters to generate (0 < ncluster < 255).
    inputBinding:
      position: 2
  - id: ngenerations
    type: int
    doc: Number of generations for the genetic algorithm.
    inputBinding:
      position: 3
  - id: fileoutput_name
    type: string
    doc: Name of the output file with the clusters.
    inputBinding:
      position: 4
  - id: random_init
    type: int
    doc: Random initialization of the population (1). With 0 the tool reads
      the initialization file out.tmp and falls back to random initialization
      when it is missing.
    inputBinding:
      position: 5
  - id: output_type
    type: int
    doc: 'Output type: 0 writes the last generation, 1 writes the minimum
      variance solution.'
    inputBinding:
      position: 6
outputs:
  - id: fileoutput
    type: File
    doc: Output file for the clustering results.
    outputBinding:
      glob: $(inputs.fileoutput_name)
  - id: variance
    type:
      - 'null'
      - File
    doc: Variance of the population at each generation.
    outputBinding:
      glob: variance.txt
  - id: bestvariance
    type:
      - 'null'
      - File
    doc: Best variance found at each generation.
    outputBinding:
      glob: bestvariance.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genclust:1.0--h470a237_0
