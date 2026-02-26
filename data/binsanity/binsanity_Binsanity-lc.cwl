cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-lc
label: binsanity_Binsanity-lc
doc: "Binsanity-lc is a workflow script that will subset assemblies larger than 100,000
  contigs using coverage prior to running Binsanity and Binsanity-refine sequentially.\n\
  \nTool homepage: https://github.com/edgraham/BinSanity"
inputs:
  - id: checkm_threads
    type:
      - 'null'
      - int
    doc: Indicate how many threads you want dedicated to the subprocess CheckM
    default: 1
    inputBinding:
      position: 101
      prefix: --checkm_threads
  - id: cluster_number
    type:
      - 'null'
      - int
    doc: Indicate a number of initial clusters for kmean
    default: 100
    inputBinding:
      position: 101
      prefix: -C
  - id: convergence_iterations
    type:
      - 'null'
      - int
    doc: Specify the convergence iteration number
    default: 400
    inputBinding:
      position: 101
      prefix: -v
  - id: coverage_file
    type: File
    doc: Specify a Coverage File
    inputBinding:
      position: 101
      prefix: -c
  - id: dampening_factor
    type:
      - 'null'
      - float
    doc: Specify a damping factor between 0.5 and 1
    default: 0.95
    inputBinding:
      position: 101
      prefix: -d
  - id: fasta_file_name
    type: File
    doc: Specify the fasta file containing contigs you want to cluster
    inputBinding:
      position: 101
      prefix: -l
  - id: fasta_location
    type: Directory
    doc: Specify directory containing Fasta File to be clustered
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer
    type:
      - 'null'
      - int
    doc: Indicate a number for the kmer calculation
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer
  - id: maximum_iterations
    type:
      - 'null'
      - int
    doc: Specify a max number of iterations
    default: 4000
    inputBinding:
      position: 101
      prefix: -m
  - id: preference
    type:
      - 'null'
      - string
    doc: Specify a preference
    default: '-3'
    inputBinding:
      position: 101
      prefix: -p
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix to append to the start of all directories generated 
      during Binsanity
    inputBinding:
      position: 101
      prefix: --Prefix
  - id: refine_preference
    type:
      - 'null'
      - string
    doc: Specify a preference for refinement
    default: '-25'
    inputBinding:
      position: 101
      prefix: --refine-preference
  - id: size_cut_off
    type:
      - 'null'
      - int
    doc: Specify the contig size cut-off
    default: 1000
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: output_directory
    type: Directory
    doc: Give a name to the directory BinSanity results will be output in
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
