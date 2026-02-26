cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgan
  - euka
label: vgan_euka
doc: "euka performs abundance estimation of eukaryotic taxa from an environmental
  DNA sample.\n\nTool homepage: https://github.com/grenaud/vgan"
inputs:
  - id: dbprefix
    type:
      - 'null'
      - string
    doc: database prefix name
    default: euka_db
    inputBinding:
      position: 101
      prefix: --dbprefix
  - id: deam3p_profile
    type:
      - 'null'
      - File
    doc: 3p deamination frequency for eukaryotic species
    default: no damage
    inputBinding:
      position: 101
      prefix: --deam3p
  - id: deam5p_profile
    type:
      - 'null'
      - File
    doc: 5p deamination frequency for eukaryotic species
    default: no damage
    inputBinding:
      position: 101
      prefix: --deam5p
  - id: entropy
    type:
      - 'null'
      - float
    doc: Minimum entropy score for a bin to be considered
    default: 1.17
    inputBinding:
      position: 101
      prefix: --entropy
  - id: euka_dir
    type:
      - 'null'
      - Directory
    doc: euka database location
    default: current wroking directory
    inputBinding:
      position: 101
      prefix: --euka_dir
  - id: fq1
    type:
      - 'null'
      - File
    doc: Input FASTQ file (for merged and single-end reads)
    inputBinding:
      position: 101
      prefix: -fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: Second input FASTQ file (for paired-end reads)
    inputBinding:
      position: 101
      prefix: -fq2
  - id: gam_input
    type:
      - 'null'
      - File
    doc: GAM input file
    inputBinding:
      position: 101
      prefix: -g
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Paired-end reads are interleaved
    default: false
    inputBinding:
      position: 101
      prefix: -i
  - id: max_bins
    type:
      - 'null'
      - int
    doc: Maximum number of bins without coverage
    default: 0
    inputBinding:
      position: 101
      prefix: --maxBins
  - id: mcmc_burnin
    type:
      - 'null'
      - int
    doc: Define the burnin period for the MCMC
    default: 100
    inputBinding:
      position: 101
      prefix: --burnin
  - id: mcmc_iterations
    type:
      - 'null'
      - int
    doc: Define the number of iterartions for the MCMC
    default: 10000
    inputBinding:
      position: 101
      prefix: --iter
  - id: min_bins
    type:
      - 'null'
      - int
    doc: Minimum number of bins with an entropy higher than the thresold
    default: 6
    inputBinding:
      position: 101
      prefix: --minBins
  - id: min_fragments
    type:
      - 'null'
      - int
    doc: Minimum amount of fragments that need to map to a group
    default: 10
    inputBinding:
      position: 101
      prefix: --minFrag
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Set the mapping quality minimum for a fragment
    default: 29
    inputBinding:
      position: 101
      prefix: --minMQ
  - id: minimizer_prefix
    type:
      - 'null'
      - string
    doc: Alternative minimizer prefix input
    default: euka_db
    inputBinding:
      position: 101
      prefix: -M
  - id: no_mcmc
    type:
      - 'null'
      - boolean
    doc: The MCMC does not run
    default: false
    inputBinding:
      position: 101
      prefix: --no-mcmc
  - id: output_fragments
    type:
      - 'null'
      - boolean
    doc: Outputs a file with all read names per taxonomic group
    default: false
    inputBinding:
      position: 101
      prefix: --outFrag
  - id: output_group
    type:
      - 'null'
      - string
    doc: Outputs all information about a taxonmic group of interest
    default: ''
    inputBinding:
      position: 101
      prefix: --outGroup
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    default: euka_output
    inputBinding:
      position: 101
      prefix: -o
  - id: output_profile_dir
    type:
      - 'null'
      - Directory
    doc: Path for output prof-file
    default: current wroking directory
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: substitution_matrix_length
    type:
      - 'null'
      - int
    doc: Set length for substitution matrix
    default: 5
    inputBinding:
      position: 101
      prefix: -l
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    default: /tmp
    inputBinding:
      position: 101
      prefix: -Z
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (-1 for all available)
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
stdout: vgan_euka.out
