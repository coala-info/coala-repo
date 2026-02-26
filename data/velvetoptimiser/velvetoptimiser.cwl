cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvetoptimiser
label: velvetoptimiser
doc: "Velvet optimiser assembly optimisation function can be built from the following
  variables.\n\nTool homepage: https://github.com/tseemann/VelvetOptimiser"
inputs:
  - id: amos_file
    type:
      - 'null'
      - boolean
    doc: Turn on velvet's read tracking and amos file output.
    default: '0'
    inputBinding:
      position: 101
      prefix: --amosfile!
  - id: dir_final
    type:
      - 'null'
      - string
    doc: The name of the directory to put the final output into.
    default: .
    inputBinding:
      position: 101
      prefix: --dir_final
  - id: end_hash
    type:
      - 'null'
      - int
    doc: The end (higher) hash value
    default: 31
    inputBinding:
      position: 101
      prefix: --hashe
  - id: genome_size
    type:
      - 'null'
      - float
    doc: "The approximate size of the genome to be assembled in megabases.\n\t\t\t
      Only used in memory use estimation. If not specified, memory use estimation\n\
      \t\t\twill not occur. If memory use is estimated, the results are shown and
      then program exits."
    default: '0'
    inputBinding:
      position: 101
      prefix: --genomesize
  - id: min_cov_cutoff
    type:
      - 'null'
      - float
    doc: The minimum cov_cutoff to be used.
    default: '0'
    inputBinding:
      position: 101
      prefix: --minCovCutoff
  - id: opt_func_cov
    type:
      - 'null'
      - string
    doc: The optimisation function used for cov_cutoff optimisation.
    default: Lbp
    inputBinding:
      position: 101
      prefix: --optFuncCov
  - id: opt_func_kmer
    type:
      - 'null'
      - string
    doc: The optimisation function used for k-mer choice.
    default: n50
    inputBinding:
      position: 101
      prefix: --optFuncKmer
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix for the output filenames, the default is the date and time 
      in the format DD-MM-YYYY-HH-MM_.
    default: auto
    inputBinding:
      position: 101
      prefix: --prefix
  - id: starting_hash
    type:
      - 'null'
      - int
    doc: The starting (lower) hash value
    default: 19
    inputBinding:
      position: 101
      prefix: --hashs
  - id: step
    type:
      - 'null'
      - int
    doc: The step in hash search..  min 2, no odd numbers
    default: 2
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: The maximum number of simulataneous velvet instances to run.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: upper_cov_cutoff
    type:
      - 'null'
      - float
    doc: The maximum coverage cutoff to consider as a multiplier of the expected
      coverage.
    default: '0'
    inputBinding:
      position: 101
      prefix: --upperCovCutoff
  - id: velvetg_options
    type:
      - 'null'
      - string
    doc: Extra velvetg options to pass through.  eg. -long_mult_cutoff 
      -max_coverage etc
    default: ''
    inputBinding:
      position: 101
      prefix: --velvetgoptions
  - id: velveth_files
    type:
      - 'null'
      - string
    doc: The file section of the velveth command line.
    default: '0'
    inputBinding:
      position: 101
      prefix: --f|velvethfiles
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging, includes all velvet output in the logfile.
    default: '0'
    inputBinding:
      position: 101
      prefix: --verbose+
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/velvetoptimiser:v2.2.6-2-deb_cv1
stdout: velvetoptimiser.out
