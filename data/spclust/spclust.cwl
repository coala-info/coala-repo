cwlVersion: v1.2
class: CommandLineTool
baseCommand: spclust
label: spclust
doc: "SpClust performs nucleotides sequences clustering using GMM.\n\nTool homepage:
  https://github.com/johnymatar/SpCLUST/"
inputs:
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: alignment mode
    inputBinding:
      position: 101
      prefix: -alignMode
  - id: input_fasta_file
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: -in
  - id: number_of_slave_processes
    type:
      - 'null'
      - int
    doc: number of slave processes
    inputBinding:
      position: 101
      prefix: -n
  - id: scoring_matrix
    type:
      - 'null'
      - string
    doc: scoring matrix
    inputBinding:
      position: 101
      prefix: -mdist
outputs:
  - id: output_clustering_file
    type: File
    doc: output clustering file
    outputBinding:
      glob: $(inputs.output_clustering_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
