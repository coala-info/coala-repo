cwlVersion: v1.2
class: CommandLineTool
baseCommand: gustaf
label: gustaf
doc: "GUSTAF uses SeqAns STELLAR to find splits as local matches on different strands
  or chromosomes. Criteria and penalties to chain these matches can be specified.
  Output file contains the breakpoints along the best chain.\n\nTool homepage: https://github.com/seqan/seqan/tree/master/apps/gustaf/README.rst"
inputs:
  - id: genome_fasta_file
    type: File
    doc: The genome file is used as database input
    inputBinding:
      position: 1
  - id: read_fasta_file
    type:
      type: array
      items: File
    doc: The read file as query input. Can be one or two files for single-end or
      paired-end reads.
    inputBinding:
      position: 2
  - id: abundance_cut
    type:
      - 'null'
      - float
    doc: k-mer overabundance cut ratio. In range [0..1].
    inputBinding:
      position: 103
      prefix: --abundanceCut
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Alphabet type of input sequences (dna, rna, dna5, rna5, protein, char).
      One of dna, dna5, rna, rna5, protein, and char.
    inputBinding:
      position: 103
      prefix: --alphabet
  - id: breakend_threshold
    type:
      - 'null'
      - int
    doc: Allowed initial or ending gap length at begin and end of read that 
      creates a breakend/breakpoint (e.g. for reads extending into insertions)
    inputBinding:
      position: 103
      prefix: --breakendThresh
  - id: breakpoint_pos_range
    type:
      - 'null'
      - int
    doc: Allowed difference in breakpoint position
    inputBinding:
      position: 103
      prefix: --breakpoint-pos-range
  - id: complex_breakpoints
    type:
      - 'null'
      - boolean
    doc: Disable inferring complex SVs
    inputBinding:
      position: 103
      prefix: --complex-breakpoints
  - id: disable_thresh
    type:
      - 'null'
      - int
    doc: Maximal number of verified matches before disabling verification for 
      one query sequence (default infinity). In range [0..inf].
    inputBinding:
      position: 103
      prefix: --disableThresh
  - id: dots
    type:
      - 'null'
      - boolean
    doc: Enable graph output in dot format
    inputBinding:
      position: 103
      prefix: --dots
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Maximal error rate (max 0.25). In range [0.0000001..0.25].
    inputBinding:
      position: 103
      prefix: --epsilon
  - id: forward
    type:
      - 'null'
      - boolean
    doc: Search only in forward strand of database.
    inputBinding:
      position: 103
      prefix: --forward
  - id: gap_threshold
    type:
      - 'null'
      - int
    doc: Allowed gap length between matches, default value corresponse to 
      expected size of microindels (5 bp)
    inputBinding:
      position: 103
      prefix: --gapThresh
  - id: init_gap_threshold
    type:
      - 'null'
      - int
    doc: Allowed initial or ending gap length at begin and end of read with no 
      breakpoint (e.g. due to sequencing errors at the end)
    inputBinding:
      position: 103
      prefix: --initGapThresh
  - id: inversion_penalty
    type:
      - 'null'
      - int
    doc: Inversion penalty
    inputBinding:
      position: 103
      prefix: --invPen
  - id: job_name
    type:
      - 'null'
      - string
    doc: Job/Queue name
    inputBinding:
      position: 103
      prefix: --jobName
  - id: kmer
    type:
      - 'null'
      - int
    doc: Length of the q-grams (max 32). In range [1..32].
    inputBinding:
      position: 103
      prefix: --kmer
  - id: library_error
    type:
      - 'null'
      - int
    doc: Library error (sd) of paired-end reads
    inputBinding:
      position: 103
      prefix: --library-error
  - id: library_size
    type:
      - 'null'
      - int
    doc: Library size of paired-end reads
    inputBinding:
      position: 103
      prefix: --library-size
  - id: matchfile
    type:
      - 'null'
      - File
    doc: File of (stellar) matches
    inputBinding:
      position: 103
      prefix: --matchfile
  - id: mate_support
    type:
      - 'null'
      - int
    doc: Number of supporting concordant mates
    inputBinding:
      position: 103
      prefix: --mate-support
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimal length of epsilon-matches. In range [0..inf].
    inputBinding:
      position: 103
      prefix: --minLength
  - id: num_matches
    type:
      - 'null'
      - int
    doc: Maximal number of kept matches per query and database. If STELLAR finds
      more matches, only the longest ones are kept.
    inputBinding:
      position: 103
      prefix: --numMatches
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallelization of I/O.
    inputBinding:
      position: 103
      prefix: --numThreads
  - id: order_penalty
    type:
      - 'null'
      - int
    doc: Intrachromosomal order change penalty
    inputBinding:
      position: 103
      prefix: --orderPen
  - id: overlap_threshold
    type:
      - 'null'
      - float
    doc: Allowed overlap between matches
    inputBinding:
      position: 103
      prefix: --overlapThresh
  - id: repeat_length
    type:
      - 'null'
      - int
    doc: Minimal length of low complexity repeats to be filtered.
    inputBinding:
      position: 103
      prefix: --repeatLength
  - id: repeat_period
    type:
      - 'null'
      - int
    doc: Maximal period of low complexity repeats to be filtered.
    inputBinding:
      position: 103
      prefix: --repeatPeriod
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Search only in reverse complement of database.
    inputBinding:
      position: 103
      prefix: --reverse
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Disable reverse complementing second mate pair input file.
    inputBinding:
      position: 103
      prefix: --revcompl
  - id: sort_thresh
    type:
      - 'null'
      - int
    doc: Number of matches triggering removal of duplicates. Choose a smaller 
      value for saving space.
    inputBinding:
      position: 103
      prefix: --sortThresh
  - id: support
    type:
      - 'null'
      - int
    doc: Number of supporting reads
    inputBinding:
      position: 103
      prefix: --support
  - id: tandem_threshold
    type:
      - 'null'
      - int
    doc: Minimal length of (small) insertion/duplication with double overlap to 
      be considered tandem repeat
    inputBinding:
      position: 103
      prefix: --tandemThresh
  - id: translocation_penalty
    type:
      - 'null'
      - int
    doc: Interchromosomal translocation penalty
    inputBinding:
      position: 103
      prefix: --transPen
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbosity mode.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: verification
    type:
      - 'null'
      - string
    doc: 'Verification strategy: exact or bestLocal or bandedGlobal One of exact,
      bestLocal, and bandedGlobal.'
    inputBinding:
      position: 103
      prefix: --verification
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 103
      prefix: --version-check
  - id: x_drop
    type:
      - 'null'
      - float
    doc: Maximal x-drop for extension.
    inputBinding:
      position: 103
      prefix: --xDrop
outputs:
  - id: gff_output_file
    type:
      - 'null'
      - File
    doc: Name of gff breakpoint output file.
    outputBinding:
      glob: $(inputs.gff_output_file)
  - id: vcf_output_file
    type:
      - 'null'
      - File
    doc: Name of vcf breakpoint output file.
    outputBinding:
      glob: $(inputs.vcf_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gustaf:1.0.10--h8ecad89_1
