cwlVersion: v1.2
class: CommandLineTool
baseCommand: pindel
label: pindel
doc: "Detection of indels and structural variations\n\nTool homepage: http://gmt.genome.wustl.edu/packages/pindel/index.html"
inputs:
  - id: additional_mismatch
    type:
      - 'null'
      - int
    doc: Pindel will only map part of a read if there are no other candidate positions
      with no more than the specified number of mismatches
    inputBinding:
      position: 101
      prefix: --additional_mismatch
  - id: anchor_quality
    type:
      - 'null'
      - int
    doc: the minimal mapping quality of the reads Pindel uses as anchor
    inputBinding:
      position: 101
      prefix: --anchor_quality
  - id: balance_cutoff
    type:
      - 'null'
      - int
    doc: the number of bases of a SV above which a more stringent filter is applied
    inputBinding:
      position: 101
      prefix: --balance_cutoff
  - id: breakdancer
    type:
      - 'null'
      - File
    doc: BreakDancer result or calls from any methods in specific format
    inputBinding:
      position: 101
      prefix: --breakdancer
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Which chr/fragment. '-c ALL' will make Pindel loop over all chromosomes.
      Can also be limited to a specific region (e.g., -c 20:5,000,000-15,000,000)
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: config_file
    type:
      - 'null'
      - File
    doc: the bam config file; either this, a pindel input file, or a pindel config
      file is required.
    inputBinding:
      position: 101
      prefix: --config-file
  - id: dd_report_duplication_reads
    type:
      - 'null'
      - boolean
    doc: Report discordant sequences and positions for mates of reads mapping inside
      dispersed duplications
    inputBinding:
      position: 101
      prefix: --DD_REPORT_DUPLICATION_READS
  - id: detect_dd
    type:
      - 'null'
      - boolean
    doc: Flag indicating whether to detect dispersed duplications
    inputBinding:
      position: 101
      prefix: --detect_DD
  - id: exclude
    type:
      - 'null'
      - File
    doc: Bed file of regions to skip
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fasta
    type: File
    doc: the reference genome sequences in fasta format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genotyping
    type:
      - 'null'
      - boolean
    doc: genotype variants if -i is also used
    inputBinding:
      position: 101
      prefix: --genotyping
  - id: include
    type:
      - 'null'
      - File
    doc: Bed file of regions to process
    inputBinding:
      position: 101
      prefix: --include
  - id: indel_correction
    type:
      - 'null'
      - boolean
    doc: search for consensus indels to corret contigs
    inputBinding:
      position: 101
      prefix: --IndelCorrection
  - id: input_sv_calls_for_assembly
    type:
      - 'null'
      - File
    doc: A filename of a list of SV calls for assembling breakpoints
    inputBinding:
      position: 101
      prefix: --input_SV_Calls_for_assembly
  - id: max_dd_breakpoint_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between dispersed duplication breakpoints
    inputBinding:
      position: 101
      prefix: --MAX_DD_BREAKPOINT_DISTANCE
  - id: max_distance_cluster_reads
    type:
      - 'null'
      - int
    doc: Maximum distance between reads for them to provide evidence for a single
      breakpoint
    inputBinding:
      position: 101
      prefix: --MAX_DISTANCE_CLUSTER_READS
  - id: max_range_index
    type:
      - 'null'
      - int
    doc: the maximum size of structural variations to be detected (1-9)
    inputBinding:
      position: 101
      prefix: --max_range_index
  - id: maximum_allowed_mismatch_rate
    type:
      - 'null'
      - float
    doc: Only reads with more than this fraction of mismatches than the reference
      genome will be considered
    inputBinding:
      position: 101
      prefix: --maximum_allowed_mismatch_rate
  - id: min_dd_breakpoint_support
    type:
      - 'null'
      - int
    doc: Minimum number of split reads for calling an exact breakpoint for dispersed
      duplications
    inputBinding:
      position: 101
      prefix: --MIN_DD_BREAKPOINT_SUPPORT
  - id: min_dd_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum number of reads needed for calling a breakpoint for dispersed duplications
    inputBinding:
      position: 101
      prefix: --MIN_DD_CLUSTER_SIZE
  - id: min_dd_map_distance
    type:
      - 'null'
      - int
    doc: Minimum mapping distance of read pairs for them to be considered discordant
    inputBinding:
      position: 101
      prefix: --MIN_DD_MAP_DISTANCE
  - id: min_distance_to_the_end
    type:
      - 'null'
      - int
    doc: the minimum number of bases required to match reference
    inputBinding:
      position: 101
      prefix: --min_distance_to_the_end
  - id: min_inversion_size
    type:
      - 'null'
      - int
    doc: only report inversions greater than this number of bases
    inputBinding:
      position: 101
      prefix: --min_inversion_size
  - id: min_num_matched_bases
    type:
      - 'null'
      - int
    doc: only consider reads as evidence if they map with more than X bases to the
      reference
    inputBinding:
      position: 101
      prefix: --min_num_matched_bases
  - id: min_perfect_match_around_bp
    type:
      - 'null'
      - int
    doc: minimum perfectly matching bases between read and reference at split point
    inputBinding:
      position: 101
      prefix: --min_perfect_match_around_BP
  - id: minimum_support_for_event
    type:
      - 'null'
      - int
    doc: Pindel only calls events which have this number or more supporting reads
    inputBinding:
      position: 101
      prefix: --minimum_support_for_event
  - id: nm
    type:
      - 'null'
      - int
    doc: the minimum number of edit distance between reads and reference genome
    inputBinding:
      position: 101
      prefix: --NM
  - id: normal_samples
    type:
      - 'null'
      - boolean
    doc: Turn on germline filtering
    inputBinding:
      position: 101
      prefix: --NormalSamples
  - id: number_of_threads
    type:
      - 'null'
      - int
    doc: the number of threads Pindel will use
    inputBinding:
      position: 101
      prefix: --number_of_threads
  - id: pindel_config_file
    type:
      - 'null'
      - File
    doc: the pindel config file, containing the names of all Pindel files that need
      to be sampled
    inputBinding:
      position: 101
      prefix: --pindel-config-file
  - id: pindel_file
    type:
      - 'null'
      - File
    doc: the Pindel input file; either this, a pindel configuration file or a bam
      configuration file is required
    inputBinding:
      position: 101
      prefix: --pindel-file
  - id: ploidy
    type:
      - 'null'
      - File
    doc: a file with Ploidy information per chr for genotype
    inputBinding:
      position: 101
      prefix: --Ploidy
  - id: report_breakpoints
    type:
      - 'null'
      - boolean
    doc: report breakpoints
    inputBinding:
      position: 101
      prefix: --report_breakpoints
  - id: report_close_mapped_reads
    type:
      - 'null'
      - boolean
    doc: report reads of which only one end could be mapped
    inputBinding:
      position: 101
      prefix: --report_close_mapped_reads
  - id: report_duplications
    type:
      - 'null'
      - boolean
    doc: report tandem duplications
    inputBinding:
      position: 101
      prefix: --report_duplications
  - id: report_interchromosomal_events
    type:
      - 'null'
      - boolean
    doc: search for interchromosomal events
    inputBinding:
      position: 101
      prefix: --report_interchromosomal_events
  - id: report_inversions
    type:
      - 'null'
      - boolean
    doc: report inversions
    inputBinding:
      position: 101
      prefix: --report_inversions
  - id: report_long_insertions
    type:
      - 'null'
      - boolean
    doc: report insertions of which the full sequence cannot be deduced
    inputBinding:
      position: 101
      prefix: --report_long_insertions
  - id: report_only_close_mapped_reads
    type:
      - 'null'
      - boolean
    doc: do not search for SVs, only report reads of which only one end could be mapped
    inputBinding:
      position: 101
      prefix: --report_only_close_mapped_reads
  - id: rp
    type:
      - 'null'
      - boolean
    doc: search for discordant read-pair to improve sensitivity
    inputBinding:
      position: 101
      prefix: --RP
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: Pindel only reports reads if they can be fit around an event within a certain
      number of mismatches
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: sequencing_error_rate
    type:
      - 'null'
      - float
    doc: the expected fraction of sequencing errors
    inputBinding:
      position: 101
      prefix: --sequencing_error_rate
  - id: window_size
    type:
      - 'null'
      - int
    doc: divides the reference in bins of X million bases to save RAM
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: output_of_breakdancer_events
    type:
      - 'null'
      - File
    doc: specify a filename to write the confirmed breakdancer events
    outputBinding:
      glob: $(inputs.output_of_breakdancer_events)
  - id: name_of_logfile
    type:
      - 'null'
      - File
    doc: Specifies a file to write Pindel's log to
    outputBinding:
      glob: $(inputs.name_of_logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pindel:0.2.5b9--h077b44d_12
