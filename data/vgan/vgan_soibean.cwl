cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgan
  - soibean
label: vgan_soibean
doc: "First, to create a taxon of interest for the --dbprefix option please use:\n\
  \      /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh [taxon name]\n\
  The taxon name must be from our database. To get an overview of the available taxa
  use:\n      /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh taxa\n\n\
  Tool homepage: https://github.com/grenaud/vgan"
inputs:
  - id: alignment_detail
    type:
      - 'null'
      - boolean
    doc: Additional TSV file with all match alignment information to identify 
      SNPs
    inputBinding:
      position: 101
      prefix: --alignment-detail
  - id: dbprefix
    type: string
    doc: Specify the prefix for the database files
    inputBinding:
      position: 101
      prefix: --dbprefix
  - id: deam3p
    type:
      - 'null'
      - File
    doc: 3p deamination frequency for eukaryotic species
    inputBinding:
      position: 101
      prefix: --deam3p
  - id: deam5p
    type:
      - 'null'
      - File
    doc: 5p deamination frequency for eukaryotic species
    inputBinding:
      position: 101
      prefix: --deam5p
  - id: fastq1
    type: File
    doc: Specify the input FASTQ file (single-end or first pair)
    inputBinding:
      position: 101
      prefix: -fq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Specify the input FASTQ file (second pair)
    inputBinding:
      position: 101
      prefix: -fq2
  - id: gam_file
    type:
      - 'null'
      - File
    doc: Specify the input GAM file (SAFARI output)
    inputBinding:
      position: 101
      prefix: -g
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: Enable interleaved input mode
    inputBinding:
      position: 101
      prefix: -i
  - id: k_value
    type:
      - 'null'
      - int
    doc: User defined value of k (k = number of expected sources)
    inputBinding:
      position: 101
      prefix: -k
  - id: mcmc_burnin
    type:
      - 'null'
      - int
    doc: Define the burn-in period for the MCMC
    inputBinding:
      position: 101
      prefix: --burnin
  - id: mcmc_chains
    type:
      - 'null'
      - int
    doc: Define the number of chains for the MCMC
    inputBinding:
      position: 101
      prefix: --chains
  - id: mcmc_iterations
    type:
      - 'null'
      - int
    doc: Define the number of iterations for the MCMC
    inputBinding:
      position: 101
      prefix: --iter
  - id: minimizer_index
    type:
      - 'null'
      - File
    doc: Specify an alternative minimizer index
    inputBinding:
      position: 101
      prefix: -M
  - id: no_mcmc
    type:
      - 'null'
      - boolean
    doc: The MCMC does not run
    inputBinding:
      position: 101
      prefix: --no-mcmc
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: path_threshold
    type:
      - 'null'
      - int
    doc: Reports all matches in additional TSV file for nodes with a number of 
      paths less or equal to the threshold set
    inputBinding:
      position: 101
      prefix: --pathThres
  - id: penalty_unsupported_paths
    type:
      - 'null'
      - int
    doc: Penalty for unsupported paths
    inputBinding:
      position: 101
      prefix: -P
  - id: random_start_nodes
    type:
      - 'null'
      - boolean
    doc: Set to get random starting nodes in the tree instead of the signature 
      nodes
    inputBinding:
      position: 101
      prefix: --randStart
  - id: soibean_dir
    type:
      - 'null'
      - Directory
    doc: Specify the directory containing the soibean files
    inputBinding:
      position: 101
      prefix: --soibean_dir
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Specify the temporary directory for intermediate files
    inputBinding:
      position: 101
      prefix: -z
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify the number of threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: tree_dir
    type:
      - 'null'
      - Directory
    doc: Specify the directory containing the HKY trees
    inputBinding:
      position: 101
      prefix: --tree_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
stdout: vgan_soibean.out
