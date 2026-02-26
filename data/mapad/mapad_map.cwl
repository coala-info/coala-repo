cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapad map
label: mapad_map
doc: "Maps reads to an indexed genome\n\nTool homepage: https://github.com/mpieva/mapAD"
inputs:
  - id: align_score_cutoff
    type:
      - 'null'
      - float
    doc: Per-base average alignment score cutoff (-c > AS / read_len^e ?)
    inputBinding:
      position: 101
      prefix: -c
  - id: batch_size
    type:
      - 'null'
      - int
    doc: The number of reads that are processed in parallel
    default: 250000
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: deamination_rate_ds_stem
    type: float
    doc: Deamination rate in double-stranded stem of a read
    inputBinding:
      position: 101
      prefix: -d
  - id: deamination_rate_ss_ends
    type: float
    doc: Deamination rate in single-stranded ends of a read
    inputBinding:
      position: 101
      prefix: -s
  - id: dispatcher
    type:
      - 'null'
      - boolean
    doc: Run in dispatcher mode for distributed computing in a network. Needs 
      workers to be spawned externally to distribute work among them.
    inputBinding:
      position: 101
      prefix: --dispatcher
  - id: divergence_base_error_rate
    type:
      - 'null'
      - float
    doc: Divergence / base error rate
    default: 0.02
    inputBinding:
      position: 101
      prefix: -D
  - id: expected_indel_rate
    type: float
    doc: Expected rate of indels between reads and reference
    inputBinding:
      position: 101
      prefix: -i
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force mapAD to overwrite the output BAM file if it already exists.
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: gap_dist_ends
    type:
      - 'null'
      - int
    doc: Disallow gaps at read ends (configurable range)
    default: 5
    inputBinding:
      position: 101
      prefix: --gap_dist_ends
  - id: gap_extension_penalty_fraction
    type:
      - 'null'
      - float
    doc: Gap extension penalty as a fraction of the representative mismatch 
      penalty
    default: 1.0
    inputBinding:
      position: 101
      prefix: -x
  - id: ignore_base_quality
    type:
      - 'null'
      - boolean
    doc: Ignore base qualities in scoring models
    inputBinding:
      position: 101
      prefix: --ignore_base_quality
  - id: library
    type: string
    doc: Library preparation method
    inputBinding:
      position: 101
      prefix: --library
  - id: max_num_gaps_open
    type:
      - 'null'
      - int
    doc: Max. number of opened gaps
    default: 2
    inputBinding:
      position: 101
      prefix: --max_num_gaps_open
  - id: min_mismatch_prob
    type:
      - 'null'
      - float
    doc: Minimum probability of the number of mismatches under `-D` base error 
      rate
    inputBinding:
      position: 101
      prefix: -p
  - id: no_search_limit_recovery
    type:
      - 'null'
      - boolean
    doc: Mapping of reads which are particularly difficult to align can exceed 
      the limits of the internal search space. By default, mapAD attempts to 
      recover from these cases by discarding the lowest scoring sub-alignments. 
      If this flag is set, these reads are instead immediately reported as 
      unmapped, which slightly increases the mapping speed at the cost of 
      decreasing sensitivity.
    inputBinding:
      position: 101
      prefix: --no_search_limit_recovery
  - id: overhang_3p_length
    type:
      - 'null'
      - float
    doc: 3'-overhang length parameter
    inputBinding:
      position: 101
      prefix: -t
  - id: overhang_5p_length
    type: float
    doc: 5'-overhang length parameter
    inputBinding:
      position: 101
      prefix: -f
  - id: port
    type:
      - 'null'
      - int
    doc: TCP port to communicate over
    default: 3130
    inputBinding:
      position: 101
      prefix: --port
  - id: read_group
    type:
      - 'null'
      - string
    doc: "Read group SAM header line. The given read group ID will be added to every
      read in the output file. Example: '@RG\tID:identifier1\tSM:sample2'."
    inputBinding:
      position: 101
      prefix: --read_group
  - id: read_length_exponent
    type:
      - 'null'
      - float
    doc: Exponent to be applied to the read length (ignored if `-c` is not used)
    default: 1.0
    inputBinding:
      position: 101
      prefix: -e
  - id: reads
    type: string
    doc: BAM/CRAM/FASTQ or FASTQ.GZ file that contains the reads to be aligned. 
      Specify "-" for reading from stdin.
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: string
    doc: Prefix of the file names of the index files. The reference FASTA file 
      itself does not need to be present.
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator
    default: 1234
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads. If 0, mapAD will select the number of 
      threads automatically.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets the level of verbosity
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output
    type: File
    doc: Path to output BAM file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
