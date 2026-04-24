cwlVersion: v1.2
class: CommandLineTool
baseCommand: VelvetOptimiser.pl
label: perl-velvetoptimiser_VelvetOptimiser.pl
doc: "Optimises Velvet assembly parameters.\n\nTool homepage: https://github.com/tseemann/VelvetOptimiser"
inputs:
  - id: velveth_input_line
    type: string
    doc: The file section of the velveth command line.
    inputBinding:
      position: 1
  - id: amos_file
    type:
      - 'null'
      - boolean
    doc: Turn on velvet's read tracking and amos file output.
    inputBinding:
      position: 102
      prefix: --amosfile
  - id: dir_final
    type:
      - 'null'
      - string
    doc: The name of the directory to put the final output into.
    inputBinding:
      position: 102
      prefix: --dir_final
  - id: end_hash
    type:
      - 'null'
      - int
    doc: The end (higher) hash value
    inputBinding:
      position: 102
      prefix: --hashe
  - id: genome_size
    type:
      - 'null'
      - float
    doc: "The approximate size of the genome to be assembled in megabases.\n\t\t\t
      Only used in memory use estimation. If not specified, memory use estimation\n\
      \t\t\twill not occur. If memory use is estimated, the results are shown and
      then program exits."
    inputBinding:
      position: 102
      prefix: --genomesize
  - id: min_cov_cutoff
    type:
      - 'null'
      - float
    doc: The minimum cov_cutoff to be used.
    inputBinding:
      position: 102
      prefix: --minCovCutoff
  - id: opt_func_cov
    type:
      - 'null'
      - string
    doc: The optimisation function used for cov_cutoff optimisation.
    inputBinding:
      position: 102
      prefix: --optFuncCov
  - id: opt_func_kmer
    type:
      - 'null'
      - string
    doc: The optimisation function used for k-mer choice.
    inputBinding:
      position: 102
      prefix: --optFuncKmer
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix for the output filenames, the default is the date and time 
      in the format DD-MM-YYYY-HH-MM_.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: starting_hash
    type:
      - 'null'
      - int
    doc: The starting (lower) hash value
    inputBinding:
      position: 102
      prefix: --hashs
  - id: step
    type:
      - 'null'
      - int
    doc: The step in hash search..  min 2, no odd numbers
    inputBinding:
      position: 102
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: The maximum number of simulataneous velvet instances to run.
    inputBinding:
      position: 102
      prefix: --threads
  - id: upper_cov_cutoff
    type:
      - 'null'
      - float
    doc: The maximum coverage cutoff to consider as a multiplier of the expected
      coverage.
    inputBinding:
      position: 102
      prefix: --upperCovCutoff
  - id: velvetg_options
    type:
      - 'null'
      - string
    doc: Extra velvetg options to pass through.  eg. -long_mult_cutoff 
      -max_coverage etc
    inputBinding:
      position: 102
      prefix: --velvetgoptions
  - id: velveth_files
    type:
      - 'null'
      - string
    doc: The file section of the velveth command line.
    inputBinding:
      position: 102
      prefix: --velvethfiles
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging, includes all velvet output in the logfile.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-velvetoptimiser:2.2.6--pl526_0
stdout: perl-velvetoptimiser_VelvetOptimiser.pl.out
