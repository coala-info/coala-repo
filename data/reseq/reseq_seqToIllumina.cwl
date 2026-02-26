cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reseq
  - seqToIllumina
label: reseq_seqToIllumina
doc: "Converts a FASTA file to FASTQ format with simulated sequencing errors.\n\n\
  Tool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs:
  - id: error_multiplier
    type:
      - 'null'
      - float
    doc: Divides the original probability of correct base calls(no substitution 
      error) by this value and renormalizes
    default: 1.0
    inputBinding:
      position: 101
      prefix: --errorMutliplier
  - id: input_file
    type: File
    doc: Input file (fasta format, gz and bz2 supported) [stdin]
    inputBinding:
      position: 101
      prefix: --input
  - id: ipf_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for iterative proportional fitting
    default: 200
    inputBinding:
      position: 101
      prefix: --ipfIterations
  - id: ipf_precision
    type:
      - 'null'
      - float
    doc: Iterative proportional fitting procedure stops after reaching this 
      precision (%)
    default: 5.0
    inputBinding:
      position: 101
      prefix: --ipfPrecision
  - id: no_indel_errors
    type:
      - 'null'
      - boolean
    doc: Simulate reads without InDel errors
    inputBinding:
      position: 101
      prefix: --noInDelErrors
  - id: no_substitution_errors
    type:
      - 'null'
      - boolean
    doc: Simulate reads without substitution errors
    inputBinding:
      position: 101
      prefix: --noSubstitutionErrors
  - id: probabilities_in
    type:
      - 'null'
      - File
    doc: Loads last estimated probabilities and continues from there if 
      precision is not met [<statsIn>.ipf]
    inputBinding:
      position: 101
      prefix: --probabilitiesIn
  - id: probabilities_out
    type:
      - 'null'
      - File
    doc: Stores the probabilities estimated by iterative proportional fitting 
      [<probabilitiesIn>]
    inputBinding:
      position: 101
      prefix: --probabilitiesOut
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed used for simulation, if none is given random seed will be used
    inputBinding:
      position: 101
      prefix: --seed
  - id: stats_file
    type: File
    doc: Profile file that contains the statistics used for simulation
    inputBinding:
      position: 101
      prefix: --statsIn
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used (0=auto)
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Sets the level of verbosity (4=everything, 0=nothing)
    default: 4
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (fastq format, gz and bz2 supported) [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
