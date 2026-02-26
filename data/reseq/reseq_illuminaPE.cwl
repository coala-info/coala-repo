cwlVersion: v1.2
class: CommandLineTool
baseCommand: reseq illuminaPE
label: reseq_illuminaPE
doc: "ReSeq version 1.1 in illuminaPE mode\n\nTool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs:
  - id: adapter_file
    type:
      - 'null'
      - File
    doc: Fasta file with adapter sequences
    inputBinding:
      position: 101
      prefix: --adapterFile
  - id: adapter_matrix
    type:
      - 'null'
      - File
    doc: 0/1 matrix with valid adapter pairing (first read in rows, second read 
      in columns)
    inputBinding:
      position: 101
      prefix: --adapterMatrix
  - id: bam_in
    type: File
    doc: Position sorted bam/sam file with reads mapped to refIn
    inputBinding:
      position: 101
      prefix: --bamIn
  - id: bin_size_bias_fit
    type:
      - 'null'
      - int
    doc: Reference sequences large then this are split for bias fitting to limit
      memory consumption
    default: 100000000
    inputBinding:
      position: 101
      prefix: --binSizeBiasFit
  - id: coverage
    type:
      - 'null'
      - int
    doc: Approximate average read depth simulated (0 = Corrected original 
      coverage)
    default: 0
    inputBinding:
      position: 101
      prefix: --coverage
  - id: error_mutliplier
    type:
      - 'null'
      - float
    doc: Divides the original probability of correct base calls(no substitution 
      error) by this value and renormalizes
    default: 1
    inputBinding:
      position: 101
      prefix: --errorMutliplier
  - id: first_reads_out
    type: File
    doc: Writes the simulated first reads into this file
    inputBinding:
      position: 101
      prefix: --firstReadsOut
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
      - int
    doc: Iterative proportional fitting procedure stops after reaching this 
      precision (%)
    default: 5
    inputBinding:
      position: 101
      prefix: --ipfPrecision
  - id: max_frag_len
    type:
      - 'null'
      - int
    doc: Maximum fragment length to include pairs into statistics
    default: 2000
    inputBinding:
      position: 101
      prefix: --maxFragLen
  - id: methylation
    type:
      - 'null'
      - File
    doc: Extended bed graph file specifying methylation for regions. Multiple 
      score columns for individual alleles are possible, but must match with 
      vcfSim. C->T conversions for 1-specified value in region.
    inputBinding:
      position: 101
      prefix: --methylation
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to include pairs into statistics
    default: 2
    inputBinding:
      position: 101
      prefix: --minMapQ
  - id: no_bias
    type:
      - 'null'
      - boolean
    doc: Do not perform bias fit. Results in uniform coverage if simulated from
    inputBinding:
      position: 101
      prefix: --noBias
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
  - id: no_tiles
    type:
      - 'null'
      - boolean
    doc: Ignore tiles for the statistics [default]
    inputBinding:
      position: 101
      prefix: --noTiles
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Approximate number of read pairs simulated (0 = Use <coverage>)
    default: 0
    inputBinding:
      position: 101
      prefix: --numReads
  - id: probabilities_in
    type:
      - 'null'
      - File
    doc: Loads last estimated probabilities and continues from there if 
      precision is not met
    inputBinding:
      position: 101
      prefix: --probabilitiesIn
  - id: read_sys_error
    type:
      - 'null'
      - File
    doc: Read systematic errors from file in fastq format (seq=dominant error, 
      qual=error percentage)
    inputBinding:
      position: 101
      prefix: --readSysError
  - id: record_base_identifier
    type:
      - 'null'
      - string
    doc: Base Identifier for the simulated fastq records, followed by a count 
      and other information about the read
    default: ReseqRead
    inputBinding:
      position: 101
      prefix: --recordBaseIdentifier
  - id: ref_bias
    type:
      - 'null'
      - string
    doc: Way to select the reference biases for simulation (keep [from refIn]/no
      [biases]/draw [with replacement from original biases]/file)
    default: keep/no
    inputBinding:
      position: 101
      prefix: --refBias
  - id: ref_bias_file
    type:
      - 'null'
      - File
    doc: 'File to read reference biases from: One sequence per file (identifier bias)'
    inputBinding:
      position: 101
      prefix: --refBiasFile
  - id: ref_in
    type: File
    doc: Reference sequences in fasta format (gz and bz2 supported)
    inputBinding:
      position: 101
      prefix: --refIn
  - id: ref_sim
    type:
      - 'null'
      - File
    doc: Reference sequences in fasta format to simulate from
    inputBinding:
      position: 101
      prefix: --refSim
  - id: second_reads_out
    type: File
    doc: Writes the simulated second reads into this file
    inputBinding:
      position: 101
      prefix: --secondReadsOut
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed used for simulation, if none is given random seed will be used
    inputBinding:
      position: 101
      prefix: --seed
  - id: stats_in
    type:
      - 'null'
      - File
    doc: Skips statistics generation and reads directly from stats file
    inputBinding:
      position: 101
      prefix: --statsIn
  - id: stats_only
    type:
      - 'null'
      - boolean
    doc: Only generate the statistics
    inputBinding:
      position: 101
      prefix: --statsOnly
  - id: stop_after_estimation
    type:
      - 'null'
      - boolean
    doc: Stop after estimating the probabilities
    inputBinding:
      position: 101
      prefix: --stopAfterEstimation
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used (0=auto)
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: tiles
    type:
      - 'null'
      - boolean
    doc: Use tiles for the statistics
    inputBinding:
      position: 101
      prefix: --tiles
  - id: vcf_in
    type:
      - 'null'
      - File
    doc: Ignore all positions with a listed variant for stats generation
    inputBinding:
      position: 101
      prefix: --vcfIn
  - id: vcf_sim
    type:
      - 'null'
      - File
    doc: Defines genotypes to simulate alleles or populations
    inputBinding:
      position: 101
      prefix: --vcfSim
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
  - id: stats_out
    type:
      - 'null'
      - File
    doc: Stores the real data statistics for reuse in given file
    outputBinding:
      glob: $(inputs.stats_out)
  - id: probabilities_out
    type:
      - 'null'
      - File
    doc: Stores the probabilities estimated by iterative proportional fitting
    outputBinding:
      glob: $(inputs.probabilities_out)
  - id: write_sys_error
    type:
      - 'null'
      - File
    doc: Write the randomly drawn systematic errors to file in fastq format 
      (seq=dominant error, qual=error percentage)
    outputBinding:
      glob: $(inputs.write_sys_error)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
