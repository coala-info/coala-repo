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
  - id: output_clustering_file_path
    type: string
    doc: Output or path parameter `output_clustering_file_path`
    inputBinding:
      position: 102
      prefix: --output-clustering-file
outputs:
  - id: output_clustering_file
    type: File
    doc: output clustering file
    outputBinding:
      glob: $(inputs.output_clustering_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
