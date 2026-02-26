cwlVersion: v1.2
class: CommandLineTool
baseCommand: snap-aligner single
label: snap-aligner_single
doc: "Aligns reads to a SNAP index.\n\nTool homepage: http://snap.cs.berkeley.edu/"
inputs:
  - id: index_dir
    type: Directory
    doc: Directory containing the SNAP index
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: List of input files to process
    inputBinding:
      position: 2
  - id: affine_gap_3_prime_bonus
    type:
      - 'null'
      - int
    doc: Bonus for alignment reaching 3' end of read
    default: 7
    inputBinding:
      position: 103
      prefix: -g3
  - id: affine_gap_5_prime_bonus
    type:
      - 'null'
      - int
    doc: Bonus for alignment reaching 5' end of read
    default: 10
    inputBinding:
      position: 103
      prefix: -g5
  - id: affine_gap_extend_cost
    type:
      - 'null'
      - int
    doc: Cost for extending a gap
    default: 1
    inputBinding:
      position: 103
      prefix: -ge
  - id: affine_gap_match_cost
    type:
      - 'null'
      - int
    doc: Cost for match
    default: 1
    inputBinding:
      position: 103
      prefix: -gm
  - id: affine_gap_open_cost
    type:
      - 'null'
      - int
    doc: Cost for opening a gap
    default: 6
    inputBinding:
      position: 103
      prefix: -go
  - id: affine_gap_substitution_cost
    type:
      - 'null'
      - int
    doc: Cost for substitution
    default: 4
    inputBinding:
      position: 103
      prefix: -gs
  - id: apply_end_of_contig_clipping_before_om
    type:
      - 'null'
      - boolean
    doc: Apply the end-of-contig soft clipping before the -om processing rather 
      than after it
    inputBinding:
      position: 103
      prefix: -ae
  - id: attach_alignment_time_tags
    type:
      - 'null'
      - boolean
    doc: 'Attach AT:i: tags to each read showing the alignment time in microseconds'
    inputBinding:
      position: 103
      prefix: -at
  - id: bam_gz_expansion_factor
    type:
      - 'null'
      - float
    doc: Increase expansion factor for BAM and GZ files
    default: 1.0
    inputBinding:
      position: 103
      prefix: -xf
  - id: clip_low_quality_bases
    type:
      - 'null'
      - string
    doc: Clip low-quality bases from front and back of read respectively (+/-)
    inputBinding:
      position: 103
      prefix: -C
  - id: clip_quality_score_range
    type:
      - 'null'
      - string
    doc: Specifies the min and max quality score to clip in Phred 33 format
    inputBinding:
      position: 103
      prefix: -cc
  - id: default_read_group
    type:
      - 'null'
      - string
    doc: Specify the default read group if it is not specified in the input file
    inputBinding:
      position: 103
      prefix: -rg
  - id: disable_affine_gap_scoring
    type:
      - 'null'
      - boolean
    doc: Disable affine gap scoring
    inputBinding:
      position: 103
      prefix: -G-
  - id: disable_alt_awareness
    type:
      - 'null'
      - boolean
    doc: Disable ALT awareness
    inputBinding:
      position: 103
      prefix: -A-
  - id: disable_cache_prefetching
    type:
      - 'null'
      - boolean
    doc: Disables cache prefetching in the genome
    inputBinding:
      position: 103
      prefix: -P
  - id: disable_gatk_haplotypecaller_mode
    type:
      - 'null'
      - boolean
    doc: Turn off optimizations specific to GATK HaplotypeCaller
    inputBinding:
      position: 103
      prefix: -hc-
  - id: disable_thread_binding
    type:
      - 'null'
      - boolean
    doc: Don't bind each thread to its processor
    inputBinding:
      position: 103
      prefix: --b
  - id: dont_map_index
    type:
      - 'null'
      - boolean
    doc: Do not map the index, read it using standard read/write calls
    inputBinding:
      position: 103
      prefix: -map-
  - id: dont_prefetch_index
    type:
      - 'null'
      - boolean
    doc: Do not prefetch the index into system cache
    inputBinding:
      position: 103
      prefix: -pre-
  - id: drop_index_after_aligning
    type:
      - 'null'
      - boolean
    doc: Drop the index after aligning and before sorting
    inputBinding:
      position: 103
      prefix: -di
  - id: emit_alt_alignments
    type:
      - 'null'
      - boolean
    doc: Emit ALT alignments
    inputBinding:
      position: 103
      prefix: -ea
  - id: emit_filter_options
    type:
      - 'null'
      - string
    doc: An alternate way to specify filter options. s = single hit (MAPQ >= 
      10), m = multiple hit (MAPQ < 10), x = not long enough to align, u = 
      unaligned, b = filter must apply to both ends of a paired-end read.
    inputBinding:
      position: 103
      prefix: -E
  - id: enable_gatk_haplotypecaller_mode
    type:
      - 'null'
      - boolean
    doc: Enable SNAP mode optimized for use with GATK HaplotypeCaller
    inputBinding:
      position: 103
      prefix: -hc
  - id: explore_popular_seeds
    type:
      - 'null'
      - boolean
    doc: Explore some hits of overly popular seeds
    inputBinding:
      position: 103
      prefix: -x
  - id: extra_search_depth
    type:
      - 'null'
      - int
    doc: Specifies the extra search depth
    default: 1
    inputBinding:
      position: 103
      prefix: -D
  - id: filter_output
    type:
      - 'null'
      - string
    doc: Filter output (a=aligned only, s=single hit only (MAPQ >= 10), 
      u=unaligned only, l=long enough to align)
    inputBinding:
      position: 103
      prefix: -F
  - id: force_mapq_zero_below
    type:
      - 'null'
      - int
    doc: Force MAPQ below this value to zero
    default: 3
    inputBinding:
      position: 103
      prefix: -fmb
  - id: ignore_unmatched_ids
    type:
      - 'null'
      - boolean
    doc: Ignore IDs that don't match in the paired-end aligner
    inputBinding:
      position: 103
      prefix: -I
  - id: include_secondary_supplementary
    type:
      - 'null'
      - boolean
    doc: Include reads from SAM or BAM files with the secondary (0x100) or 
      supplementary (0x800) flag set
    inputBinding:
      position: 103
      prefix: -sa
  - id: kill_if_too_slow
    type:
      - 'null'
      - boolean
    doc: Kill if too slow. Monitor our progress and kill ourself if we're not 
      moving fast enough
    inputBinding:
      position: 103
      prefix: -kts
  - id: low_priority
    type:
      - 'null'
      - boolean
    doc: Run SNAP at low scheduling priority (Only implemented on Windows)
    inputBinding:
      position: 103
      prefix: -lp
  - id: max_alignments_per_contig
    type:
      - 'null'
      - int
    doc: Limit the number of alignments generated by -om to this many per contig
    inputBinding:
      position: 103
      prefix: -mpc
  - id: max_alignments_per_read
    type:
      - 'null'
      - int
    doc: Limit the number of alignments per read generated by -om
    inputBinding:
      position: 103
      prefix: -omax
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: Maximum edit distance allowed per read or pair absent indels
    default: 27
    inputBinding:
      position: 103
      prefix: -d
  - id: max_hits_per_seed
    type:
      - 'null'
      - int
    doc: Maximum hits to consider per seed
    default: 300
    inputBinding:
      position: 103
      prefix: -h
  - id: max_indel_distance
    type:
      - 'null'
      - int
    doc: Maximum distance allowed per read for indels
    default: 40
    inputBinding:
      position: 103
      prefix: -i
  - id: max_score_gap_prefer_non_alt
    type:
      - 'null'
      - int
    doc: Maximum score gap to prefer a non-ALT alignment
    default: 64
    inputBinding:
      position: 103
      prefix: -asg
  - id: min_read_length_to_align
    type:
      - 'null'
      - int
    doc: Specify the minimum read length to align
    default: 50
    inputBinding:
      position: 103
      prefix: -mrl
  - id: min_seed_matches
    type:
      - 'null'
      - int
    doc: Minimum seed matches per location
    default: 1
    inputBinding:
      position: 103
      prefix: -ms
  - id: no_banded_affine_gap
    type:
      - 'null'
      - boolean
    doc: Don't use the banded affine gap optimization
    inputBinding:
      position: 103
      prefix: -nb
  - id: no_edit_distance_scoring_before_affine_gap
    type:
      - 'null'
      - boolean
    doc: Don't try edit distance scoring before doing affine gap
    inputBinding:
      position: 103
      prefix: -ne
  - id: no_ordering
    type:
      - 'null'
      - boolean
    doc: "No Ordering: don't order the evalutation of potential alignments"
    inputBinding:
      position: 103
      prefix: -no
  - id: no_truncate_searches
    type:
      - 'null'
      - boolean
    doc: Don't truncate searches based on missed seed hits
    inputBinding:
      position: 103
      prefix: -nt
  - id: no_ukkonen
    type:
      - 'null'
      - boolean
    doc: "No Ukkonen: don't reduce edit distance search based on prior candidates"
    inputBinding:
      position: 103
      prefix: -nu
  - id: num_seeds
    type:
      - 'null'
      - int
    doc: Number of seeds to use per read
    inputBinding:
      position: 103
      prefix: -n
  - id: output_multiple_alignments
    type:
      - 'null'
      - int
    doc: Output multiple alignments. Takes as a parameter the maximum extra edit
      distance relative to the best alignment
    inputBinding:
      position: 103
      prefix: -om
  - id: prefetch_index
    type:
      - 'null'
      - boolean
    doc: Prefetch the index into system cache
    inputBinding:
      position: 103
      prefix: -pre
  - id: preserve_fastq_comments
    type:
      - 'null'
      - boolean
    doc: Preserve FASTQ comments
    inputBinding:
      position: 103
      prefix: -pfc
  - id: preserve_soft_clipping
    type:
      - 'null'
      - boolean
    doc: Preserve the soft clipping for reads coming from SAM or BAM files
    inputBinding:
      position: 103
      prefix: -pc
  - id: profile_affine_gap_scoring
    type:
      - 'null'
      - boolean
    doc: Profile affine-gap scoring to show how often it forces single-end 
      alignment
    inputBinding:
      position: 103
      prefix: -proAg
  - id: profile_alignment
    type:
      - 'null'
      - boolean
    doc: Profile alignment to give you an idea of how much time is spent 
      aligning and how much waiting for IO
    inputBinding:
      position: 103
      prefix: -pro
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: "Quiet mode: don't print status messages"
    inputBinding:
      position: 103
      prefix: -q
  - id: read_group_line
    type:
      - 'null'
      - string
    doc: Specify the entire read group line for the SAM/BAM output
    inputBinding:
      position: 103
      prefix: -R
  - id: run_speed_file
    type:
      - 'null'
      - File
    doc: Specify the name of a file to contain the run speed
    inputBinding:
      position: 103
      prefix: -pf
  - id: seed_coverage
    type:
      - 'null'
      - float
    doc: Seed coverage (i.e., readSize/seedSize). Exclusive with -n.
    inputBinding:
      position: 103
      prefix: -sc
  - id: sort_intermediate_dir
    type:
      - 'null'
      - Directory
    doc: Specifies the sort intermediate directory
    inputBinding:
      position: 103
      prefix: -sid
  - id: sort_memory
    type:
      - 'null'
      - string
    doc: Memory to use for sorting in Gbytes. Default is 1 Gbyte/thread.
    inputBinding:
      position: 103
      prefix: -sm
  - id: sort_output
    type:
      - 'null'
      - boolean
    doc: Sort output file by alignment location
    inputBinding:
      position: 103
      prefix: -so
  - id: stop_on_first_match
    type:
      - 'null'
      - boolean
    doc: Stop on first match within edit distance limit (filtering mode, 
      single-end only)
    inputBinding:
      position: 103
      prefix: -f
  - id: super_quiet_mode
    type:
      - 'null'
      - boolean
    doc: "Super quiet mode: don't print status or error messages"
    inputBinding:
      position: 103
      prefix: -qq
  - id: suppress_additional_processing
    type:
      - 'null'
      - boolean
    doc: Suppress additional processing (sorted BAM output only)
    inputBinding:
      position: 103
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default is one per core)
    inputBinding:
      position: 103
      prefix: -t
  - id: use_file_mapping
    type:
      - 'null'
      - boolean
    doc: Use file mapping to load the index rather than reading it
    inputBinding:
      position: 103
      prefix: -map
  - id: use_hadoop_prefixes
    type:
      - 'null'
      - boolean
    doc: Use Hadoop-style prefixes on error messages, and emit hadoop-style 
      progress messages
    inputBinding:
      position: 103
      prefix: -hdp
  - id: use_huge_pages
    type:
      - 'null'
      - boolean
    doc: Indicates to use huge pages
    inputBinding:
      position: 103
      prefix: -hp
  - id: use_new_cigar_strings
    type:
      - 'null'
      - boolean
    doc: Use the new style CIGAR strings with = and X rather than M
    inputBinding:
      position: 103
      prefix: -=
  - id: write_buffer_size
    type:
      - 'null'
      - int
    doc: Write buffer size in megabytes
    default: 16
    inputBinding:
      position: 103
      prefix: -wbs
  - id: write_internal_score
    type:
      - 'null'
      - string
    doc: Write SNAP's internal score for an alignment into the output. The value
      following -is specifies the tag to use, and must be a two letter value 
      starting with X, Y or Z.
    inputBinding:
      position: 103
      prefix: -is
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output alignments to filename in SAM or BAM format
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snap-aligner:2.0.5--h077b44d_2
