cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mpiexec
label: spclust
doc: "SpClust performs nucleotides sequences clustering using GMM. It runs under MPI: mpiexec -n [number of processes] spclust -in [input fasta file] -out [output clustering file]. The input file name must end in .fasta.\n\nTool homepage: https://github.com/johnymatar/SpCLUST/"
inputs:
  - id: number_of_processes
    type:
      - 'null'
      - int
    default: 2
    doc: "Number of MPI processes given to mpiexec -n (one master plus slave processes; at least 2)"
    inputBinding:
      position: 1
      prefix: -n
  - id: input_fasta_file
    type: File
    doc: "Input fasta file (file name must end in .fasta)"
    inputBinding:
      position: 11
      prefix: -in
  - id: output_clustering_file
    type: string
    doc: "Output clustering file"
    inputBinding:
      position: 12
      prefix: -out
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: "Alignment mode: fast, moderate or maxPrecision (default). fast and moderate limit the number of iterations for the alignment to 2 and 4 respectively (using MUSCLE)."
    inputBinding:
      position: 13
      prefix: -alignMode
  - id: scoring_matrix
    type:
      - 'null'
      - string
    doc: "Scoring matrix: EDNAFULL (default), BLOSUM62 or PAM250"
    inputBinding:
      position: 14
      prefix: -mdist
arguments:
  - position: 10
    valueFrom: spclust
outputs:
  - id: clustering_file
    type: File
    doc: Output clustering file
    outputBinding:
      glob: $(inputs.output_clustering_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
