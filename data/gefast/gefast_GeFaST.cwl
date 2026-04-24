cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeFaST
label: gefast_GeFaST
doc: "Cluster amplicons based on sequence similarity and quality scores.\n\nTool homepage:
  https://github.com/romueller/gefast"
inputs:
  - id: mode
    type: string
    doc: 'The abbreviation of the mode. Modes: lev, as, qlev, qas, cons, derep'
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: By default, GeFaST expects a comma-separated list of file paths as its 
      second argument. This behaviour can be changed with the --list_file 
      option.
    inputBinding:
      position: 2
  - id: config
    type: File
    doc: The file path of the configuration file containing the (basic) 
      configuration for this execution of GeFaST.
    inputBinding:
      position: 3
  - id: alphabet
    type:
      - 'null'
      - string
    doc: discard sequences with other characters
    inputBinding:
      position: 104
      prefix: --alphabet
  - id: boundary
    type:
      - 'null'
      - int
    doc: mass boundary distinguishing between light and heavy clusters during 
      refinement
    inputBinding:
      position: 104
      prefix: --boundary
  - id: break_swarms
    type:
      - 'null'
      - boolean
    doc: do not extend cluster when the new amplicon has a larger abundance than
      the current subseed
    inputBinding:
      position: 104
      prefix: --break_swarms
  - id: clusterer
    type:
      - 'null'
      - string
    doc: use the specified component to cluster the amplicons
    inputBinding:
      position: 104
      prefix: --clusterer
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: penalty for extending a gap during pairwise global alignment 
      computation
    inputBinding:
      position: 104
      prefix: --gap_extension_penalty
  - id: gap_opening_penalty
    type:
      - 'null'
      - int
    doc: penalty for opening a gap during pairwise global alignment computation
    inputBinding:
      position: 104
      prefix: --gap_opening_penalty
  - id: list_file
    type:
      - 'null'
      - File
    doc: consider <input> option as path to file containing list of actual input
      files (one path per line)
    inputBinding:
      position: 104
      prefix: --list_file
  - id: match_reward
    type:
      - 'null'
      - int
    doc: reward for nucleotide match during pairwise global alignment 
      computation
    inputBinding:
      position: 104
      prefix: --match_reward
  - id: max_abundance
    type:
      - 'null'
      - int
    doc: discard more abundant sequences
    inputBinding:
      position: 104
      prefix: --max_abundance
  - id: max_length
    type:
      - 'null'
      - int
    doc: discard longer sequences
    inputBinding:
      position: 104
      prefix: --max_length
  - id: min_abundance
    type:
      - 'null'
      - int
    doc: discard less abundant sequences
    inputBinding:
      position: 104
      prefix: --min_abundance
  - id: min_length
    type:
      - 'null'
      - int
    doc: discard shorter sequences
    inputBinding:
      position: 104
      prefix: --min_length
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: penalty for nucleotide mismatch during pairwise global alignment 
      computation
    inputBinding:
      position: 104
      prefix: --mismatch_penalty
  - id: mothur
    type:
      - 'null'
      - boolean
    doc: output clusters in mothur list file format
    inputBinding:
      position: 104
      prefix: --mothur
  - id: output_generator
    type:
      - 'null'
      - string
    doc: use the specified component to generate the requested outputs
    inputBinding:
      position: 104
      prefix: --output_generator
  - id: preprocessor
    type:
      - 'null'
      - string
    doc: use the specified component to perform the preprocessing
    inputBinding:
      position: 104
      prefix: --preprocessor
  - id: quality_encoding
    type:
      - 'null'
      - string
    doc: change expected quality encoding (FASTQ inputs)
    inputBinding:
      position: 104
      prefix: --quality_encoding
  - id: refinement_threshold
    type:
      - 'null'
      - float
    doc: distance threshold in refinement phase
    inputBinding:
      position: 104
      prefix: --refinement_threshold
  - id: refiner
    type:
      - 'null'
      - string
    doc: use the specified component to refine the clusters
    inputBinding:
      position: 104
      prefix: --refiner
  - id: sep_abundance
    type:
      - 'null'
      - string
    doc: change separator symbol between identifier and abundance
    inputBinding:
      position: 104
      prefix: --sep_abundance
  - id: threshold
    type:
      - 'null'
      - float
    doc: distance threshold in clustering phase
    inputBinding:
      position: 104
      prefix: --threshold
outputs:
  - id: output_internal
    type:
      - 'null'
      - File
    doc: output links underlying the cluster to file
    outputBinding:
      glob: $(inputs.output_internal)
  - id: output_otus
    type:
      - 'null'
      - File
    doc: output clusters to file
    outputBinding:
      glob: $(inputs.output_otus)
  - id: output_statistics
    type:
      - 'null'
      - File
    doc: output statistics to file
    outputBinding:
      glob: $(inputs.output_statistics)
  - id: output_seeds
    type:
      - 'null'
      - File
    doc: output seeds to file
    outputBinding:
      glob: $(inputs.output_seeds)
  - id: output_uclust
    type:
      - 'null'
      - File
    doc: create UCLUST-like output file
    outputBinding:
      glob: $(inputs.output_uclust)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gefast:2.0.1--h4ac6f70_3
