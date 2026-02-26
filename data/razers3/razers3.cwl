cwlVersion: v1.2
class: CommandLineTool
baseCommand: razers3
label: razers3
doc: "RazerS 3 is a versatile full-sensitive read mapper based on k-mer counting and
  seeding filters. It supports single and paired-end mapping, shared-memory parallelism,
  and optimally parametrizes the filter based on a user-defined minimal sensitivity.
  See https://www.seqan.de/apps/razers3 for more information.\n\nTool homepage: https://www.seqan.de/apps/razers3.html"
inputs:
  - id: genome_file
    type: File
    doc: 'A reference genome file. Valid filetypes are: .sam[.*], .raw[.*], .gbk[.*],
      .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*],
      .fa[.*], .embl[.*], and .bam, where * is any of the following extensions: gz,
      bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 1
  - id: reads_file
    type:
      type: array
      items: File
    doc: 'Either one (single-end) or two (paired-end) read files. Valid filetypes
      are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
      .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
      of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 2
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Dump the alignment for each match (only razer or fasta format).
    inputBinding:
      position: 103
      prefix: --alignment
  - id: available_matches_memory_size
    type:
      - 'null'
      - int
    doc: Bytes of main memory available for storing matches. In range [-1..inf].
    default: 0
    inputBinding:
      position: 103
      prefix: --available-matches-memory-size
  - id: compact_mult
    type:
      - 'null'
      - float
    doc: Multiply compaction threshold by this value after reaching and 
      compacting. In range [0..inf].
    default: 2.2
    inputBinding:
      position: 103
      prefix: --compact-mult
  - id: distance_range
    type:
      - 'null'
      - int
    doc: 'Only consider matches with at most NUM more errors compared to the best.
      Default: output all.'
    inputBinding:
      position: 103
      prefix: --distance-range
  - id: dont_shrink_alignments
    type:
      - 'null'
      - boolean
    doc: Disable alignment shrinking in SAM. This is required for generating a 
      gold mapping for Rabema.
    inputBinding:
      position: 103
      prefix: --dont-shrink-alignments
  - id: error_distr
    type:
      - 'null'
      - string
    doc: Write error distribution to FILE.
    inputBinding:
      position: 103
      prefix: --error-distr
  - id: filter
    type:
      - 'null'
      - string
    doc: 'Select k-mer filter. One of pigeonhole and swift. Default: pigeonhole.'
    default: pigeonhole
    inputBinding:
      position: 103
      prefix: --filter
  - id: forward
    type:
      - 'null'
      - boolean
    doc: Map reads only to forward strands.
    inputBinding:
      position: 103
      prefix: --forward
  - id: full_readid
    type:
      - 'null'
      - boolean
    doc: Use the whole read id (don't clip after whitespace).
    inputBinding:
      position: 103
      prefix: --full-readid
  - id: genome_naming
    type:
      - 'null'
      - int
    doc: Select how genomes are named (see Naming section below). In range 
      [0..1].
    default: 0
    inputBinding:
      position: 103
      prefix: --genome-naming
  - id: library_error
    type:
      - 'null'
      - int
    doc: Paired-end library length tolerance. In range [0..inf].
    default: 50
    inputBinding:
      position: 103
      prefix: --library-error
  - id: library_length
    type:
      - 'null'
      - int
    doc: Paired-end library length. In range [1..inf].
    default: 220
    inputBinding:
      position: 103
      prefix: --library-length
  - id: load_factor
    type:
      - 'null'
      - float
    doc: Set the load factor for the open addressing k-mer index. In range 
      [1..inf].
    default: 1.6
    inputBinding:
      position: 103
      prefix: --load-factor
  - id: match_histo_start_threshold
    type:
      - 'null'
      - int
    doc: When to start histogram. In range [1..inf].
    default: 5
    inputBinding:
      position: 103
      prefix: --match-histo-start-threshold
  - id: match_n
    type:
      - 'null'
      - boolean
    doc: 'N matches all other characters. Default: N matches nothing.'
    inputBinding:
      position: 103
      prefix: --match-N
  - id: max_hits
    type:
      - 'null'
      - int
    doc: Output only <NUM> of the best hits. In range [1..inf].
    default: 100
    inputBinding:
      position: 103
      prefix: --max-hits
  - id: mismatch_file
    type:
      - 'null'
      - string
    doc: Write mismatch patterns to FILE.
    inputBinding:
      position: 103
      prefix: --mismatch-file
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Set the percent mutation rate (pigeonhole). In range [0..20].
    default: 5.0
    inputBinding:
      position: 103
      prefix: --mutation-rate
  - id: no_compact_frac
    type:
      - 'null'
      - float
    doc: Don't compact if in this last fraction of genome. In range [0..1].
    default: 0.05
    inputBinding:
      position: 103
      prefix: --no-compact-frac
  - id: no_gaps
    type:
      - 'null'
      - boolean
    doc: 'Allow only mismatches, no indels. Default: allow both.'
    inputBinding:
      position: 103
      prefix: --no-gaps
  - id: overabundance_cut
    type:
      - 'null'
      - int
    doc: Set k-mer overabundance cut ratio. In range [0..1].
    default: 1
    inputBinding:
      position: 103
      prefix: --overabundance-cut
  - id: overlap_length
    type:
      - 'null'
      - int
    doc: Manually set the overlap length of adjacent k-mers (pigeonhole). In 
      range [0..inf].
    inputBinding:
      position: 103
      prefix: --overlap-length
  - id: parallel_verification_max_package_count
    type:
      - 'null'
      - int
    doc: Largest number of packages to create for verification per thread-1. In 
      range [1..inf].
    default: 100
    inputBinding:
      position: 103
      prefix: --parallel-verification-max-package-count
  - id: parallel_verification_size
    type:
      - 'null'
      - int
    doc: Verify candidates in packages of this size. In range [1..inf].
    default: 100
    inputBinding:
      position: 103
      prefix: --parallel-verification-size
  - id: parallel_window_size
    type:
      - 'null'
      - int
    doc: Collect candidates in windows of this length. In range [1..inf].
    default: 500000
    inputBinding:
      position: 103
      prefix: --parallel-window-size
  - id: param_dir
    type:
      - 'null'
      - string
    doc: Read user-computed parameter files in the directory <DIR> (swift).
    inputBinding:
      position: 103
      prefix: --param-dir
  - id: percent_identity
    type:
      - 'null'
      - float
    doc: Percent identity threshold. In range [50..100].
    default: 95.0
    inputBinding:
      position: 103
      prefix: --percent-identity
  - id: position_format
    type:
      - 'null'
      - int
    doc: Select begin/end position numbering (see Coordinate section below). In 
      range [0..1].
    default: 0
    inputBinding:
      position: 103
      prefix: --position-format
  - id: purge_ambiguous
    type:
      - 'null'
      - boolean
    doc: Purge reads with more than <max-hits> best matches.
    inputBinding:
      position: 103
      prefix: --purge-ambiguous
  - id: read_naming
    type:
      - 'null'
      - int
    doc: Select how reads are named (see Naming section below). In range [0..3].
    default: 0
    inputBinding:
      position: 103
      prefix: --read-naming
  - id: recognition_rate
    type:
      - 'null'
      - float
    doc: Percent recognition rate. In range [80..100].
    default: 100.0
    inputBinding:
      position: 103
      prefix: --recognition-rate
  - id: repeat_length
    type:
      - 'null'
      - int
    doc: Skip simple-repeats of length <NUM>. In range [1..inf].
    default: 1000
    inputBinding:
      position: 103
      prefix: --repeat-length
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Map reads only to reverse strands.
    inputBinding:
      position: 103
      prefix: --reverse
  - id: shape
    type:
      - 'null'
      - string
    doc: Manually set k-mer shape.
    inputBinding:
      position: 103
      prefix: --shape
  - id: sort_order
    type:
      - 'null'
      - int
    doc: Select how matches are sorted (see Sorting section below). In range 
      [0..1].
    default: 0
    inputBinding:
      position: 103
      prefix: --sort-order
  - id: taboo_length
    type:
      - 'null'
      - int
    doc: Set taboo length (swift). In range [1..inf].
    default: 1
    inputBinding:
      position: 103
      prefix: --taboo-length
  - id: thread_count
    type:
      - 'null'
      - int
    doc: Set the number of threads to use (0 to force sequential mode). In range
      [0..inf].
    default: 1
    inputBinding:
      position: 103
      prefix: --thread-count
  - id: threshold
    type:
      - 'null'
      - int
    doc: Manually set minimum k-mer count threshold (swift). In range [1..inf].
    inputBinding:
      position: 103
      prefix: --threshold
  - id: trim_reads
    type:
      - 'null'
      - int
    doc: 'Trim reads to given length. Default: off. In range [14..inf].'
    default: off
    inputBinding:
      position: 103
      prefix: --trim-reads
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Output only unique best matches (-m 1 -dr 0 -pa).
    inputBinding:
      position: 103
      prefix: --unique
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    default: true
    inputBinding:
      position: 103
      prefix: --version-check
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Very verbose mode.
    inputBinding:
      position: 103
      prefix: --vverbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Mapping result filename (use - to dump to stdout in razers format). Default:
      <READS FILE>.razers. Valid filetypes are: .sam, .razers, .gff, .fasta, .fa,
      .eland, .bam, and .afg.'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/razers3:3.5.12--h7f3286b_0
