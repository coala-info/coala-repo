cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar x-mapper.jar
label: x-mapper
doc: "Aligns genomic sequences quickly and accurately using relatively high amounts
  of memory\n\nTool homepage: https://github.com/mathjeff/mapper"
inputs:
  - id: additional_extend_insertion_penalty
    type:
      - 'null'
      - float
    doc: additional penalty of an extension to an existing insertion
    inputBinding:
      position: 101
      prefix: --additional-extend-insertion-penalty
  - id: allow_duplicate_contig_names
    type:
      - 'null'
      - boolean
    doc: if multiple contigs have the same name, continue instead of throwing an
      error.
    inputBinding:
      position: 101
      prefix: --allow-duplicate-contig-names
  - id: ambiguity_penalty
    type:
      - 'null'
      - float
    doc: the penalty of a fully ambiguous position. This penalty is applied in 
      the case of an unknown basepair in the reference ('N').
    inputBinding:
      position: 101
      prefix: --ambiguity-penalty
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: save and load analyses from this directory to save time.
    inputBinding:
      position: 101
      prefix: --cache-dir
  - id: distinguish_query_ends
    type:
      - 'null'
      - float
    doc: In the output vcf file, we separately display which queries aligned at 
      each position with <fraction> of the end of the query and which didn't.
    inputBinding:
      position: 101
      prefix: --distinguish-query-ends
  - id: distinguish_query_ends
    type:
      - 'null'
      - float
    doc: When detecting indels, only consider the middle <fraction> of each 
      query
    inputBinding:
      position: 101
      prefix: --distinguish-query-ends
  - id: extend_indel_penalty
    type:
      - 'null'
      - float
    doc: the penalty of an extension to an existing insertion or deletion
    inputBinding:
      position: 101
      prefix: --extend-indel-penalty
  - id: indel_continue_threshold_supporting_depth_fraction
    type:
      - 'null'
      - float
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report support for a continuation of an 
      insertion or deletion
    inputBinding:
      position: 101
      prefix: --indel-continue-threshold
  - id: indel_continue_threshold_supporting_depth_fraction
    type:
      - 'null'
      - float
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report it as a continuation of an insertion or 
      deletion
    inputBinding:
      position: 101
      prefix: --indel-continue-threshold
  - id: indel_continue_threshold_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report support for a continuation of an 
      insertion or deletion
    inputBinding:
      position: 101
      prefix: --indel-continue-threshold
  - id: indel_continue_threshold_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report it as a continuation of an insertion or 
      deletion
    inputBinding:
      position: 101
      prefix: --indel-continue-threshold
  - id: indel_start_threshold_supporting_depth_fraction
    type:
      - 'null'
      - float
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report support for the start of an insertion or 
      deletion
    inputBinding:
      position: 101
      prefix: --indel-start-threshold
  - id: indel_start_threshold_supporting_depth_fraction
    type:
      - 'null'
      - float
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report it as the start of an insertion or 
      deletion
    inputBinding:
      position: 101
      prefix: --indel-start-threshold
  - id: indel_start_threshold_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report support for the start of an insertion or 
      deletion
    inputBinding:
      position: 101
      prefix: --indel-start-threshold
  - id: indel_start_threshold_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total (middle) depth and minimum supporting depth fraction 
      required at a position to report it as the start of an insertion or 
      deletion
    inputBinding:
      position: 101
      prefix: --indel-start-threshold
  - id: indel_threshold_supporting_depth_frequency
    type:
      - 'null'
      - float
    doc: Alias for --indel-start-threshold <min total depth> <min supporting 
      depth frequency> and --indel-continue-threshold <min total depth> <min 
      supporting depth frequency>
    inputBinding:
      position: 101
      prefix: --indel-threshold
  - id: indel_threshold_supporting_depth_frequency
    type:
      - 'null'
      - float
    doc: Alias for --indel-start-threshold <min total depth> <min supporting 
      depth frequency> and --indel-continue-threshold <min total depth> <min 
      supporting depth frequency>
    inputBinding:
      position: 101
      prefix: --indel-threshold
  - id: indel_threshold_total_depth
    type:
      - 'null'
      - int
    doc: Alias for --indel-start-threshold <min total depth> <min supporting 
      depth frequency> and --indel-continue-threshold <min total depth> <min 
      supporting depth frequency>
    inputBinding:
      position: 101
      prefix: --indel-threshold
  - id: indel_threshold_total_depth
    type:
      - 'null'
      - int
    doc: Alias for --indel-start-threshold <min total depth> <min supporting 
      depth frequency> and --indel-continue-threshold <min total depth> <min 
      supporting depth frequency>
    inputBinding:
      position: 101
      prefix: --indel-threshold
  - id: infer_ancestors
    type:
      - 'null'
      - boolean
    doc: Requests that Mapper look for parts of the genome that likely shared a 
      common ancestor in the past, and will lower the penalty of an alignment 
      that mismatches the given reference but matches the inferred common 
      ancestor.
    inputBinding:
      position: 101
      prefix: --infer-ancestors
  - id: max_num_matches
    type:
      - 'null'
      - int
    doc: the maximum number of positions on the reference that any query may 
      match.
    inputBinding:
      position: 101
      prefix: --max-num-matches
  - id: max_penalty
    type:
      - 'null'
      - float
    doc: for a match to be reported, its penalty must be no larger than this 
      value times its length
    inputBinding:
      position: 101
      prefix: --max-penalty
  - id: max_penalty_span
    type:
      - 'null'
      - float
    doc: After Mapper finds an alignment having a certain penalty, Mapper will 
      also look for and report alignments having penalties no more than 
      <extraPenalty> additional penalty.
    inputBinding:
      position: 101
      prefix: --max-penalty-span
  - id: new_indel_penalty
    type:
      - 'null'
      - float
    doc: the penalty of a new insertion or deletion of length 0
    inputBinding:
      position: 101
      prefix: --new-indel-penalty
  - id: no_gapmers
    type:
      - 'null'
      - boolean
    doc: When Mapper attempts to identify locations at which the query might 
      align to the reference, Mapper first splits the query into smaller pieces 
      and looks for an exact match for each piece. By default, these pieces 
      contain noncontiguous basepairs and might look like XXXXXXXX____XXXX. This
      flag makes these pieces be contiguous instead to look more like 
      XXXXXXXXXXXX.
    inputBinding:
      position: 101
      prefix: --no-gapmers
  - id: no_infer_ancestors
    type:
      - 'null'
      - boolean
    doc: Disables ancestor inference.
    inputBinding:
      position: 101
      prefix: --no-infer-ancestors
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: if no output is requested, skip writing output rather than throwing an 
      error
    inputBinding:
      position: 101
      prefix: --no-output
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads to use at once for processing. Higher values will run
      more quickly on a system that has that many CPUs available.
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: paired_queries_file1
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina-style paired-end reads to align to the reference. For each 
      read <r1> in <file1> and the corresponding <r2> in <file2>, the alignment 
      position of <r1> is expected to be slightly before the alignment position 
      of the reverse complement of <r2>.
    inputBinding:
      position: 101
      prefix: --paired-queries
  - id: paired_queries_file2
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina-style paired-end reads to align to the reference. For each 
      read <r1> in <file1> and the corresponding <r2> in <file2>, the alignment 
      position of <r1> is expected to be slightly before the alignment position 
      of the reverse complement of <r2>.
    inputBinding:
      position: 101
      prefix: --paired-queries
  - id: queries
    type:
      - 'null'
      - type: array
        items: File
    doc: the reads to align to the reference. Should be in .fastq or .fasta 
      format.
    inputBinding:
      position: 101
      prefix: --queries
  - id: reference
    type:
      type: array
      items: File
    doc: the reference to use. Should be in .fasta/.fa/.fna or .fastq/.fq format
      or a .gz of one of those formats.
    inputBinding:
      position: 101
      prefix: --reference
  - id: snp_penalty
    type:
      - 'null'
      - float
    doc: the penalty of a point mutation
    inputBinding:
      position: 101
      prefix: --snp-penalty
  - id: snp_threshold_supporting_depth_fraction
    type:
      - 'null'
      - float
    doc: The minimum total depth and minimum supporting depth fraction required 
      at a position to report the support for the mutation
    inputBinding:
      position: 101
      prefix: --snp-threshold
  - id: snp_threshold_supporting_depth_fraction
    type:
      - 'null'
      - float
    doc: The minimum total depth and minimum supporting depth fraction required 
      at a position to report it as a point mutation
    inputBinding:
      position: 101
      prefix: --snp-threshold
  - id: snp_threshold_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total depth and minimum supporting depth fraction required 
      at a position to report the support for the mutation
    inputBinding:
      position: 101
      prefix: --snp-threshold
  - id: snp_threshold_total_depth
    type:
      - 'null'
      - int
    doc: The minimum total depth and minimum supporting depth fraction required 
      at a position to report it as a point mutation
    inputBinding:
      position: 101
      prefix: --snp-threshold
  - id: spacing_distance_per_penalty
    type:
      - 'null'
      - int
    doc: That additional penalty equals (the difference between the actual 
      distance and <expected>) divided by <distancePerPenalty>, unless the two 
      query sequence alignments would overlap, in which case the additional 
      penalty is 0.
    inputBinding:
      position: 101
      prefix: --spacing
  - id: spacing_expected
    type:
      - 'null'
      - int
    doc: Any query alignment whose inner distance deviates from <expected> has 
      an additional penalty added.
    inputBinding:
      position: 101
      prefix: --spacing
  - id: split_queries_past_size
    type:
      - 'null'
      - int
    doc: Any queries longer than <size> will be split into smaller queries.
    inputBinding:
      position: 101
      prefix: --split-queries-past-size
  - id: vcf_exclude_non_mutations
    type:
      - 'null'
      - boolean
    doc: if set, the output vcf file will exclude positions where no mutations 
      were detected
    inputBinding:
      position: 101
      prefix: --vcf-exclude-non-mutations
  - id: vcf_omit_support_reads
    type:
      - 'null'
      - boolean
    doc: By default, the vcf file has a column showing one or more supporting 
      reads for each variant. If set, the output vcf file will hide the 
      supporting reads for each variant.
    inputBinding:
      position: 101
      prefix: --vcf-omit-support-reads
  - id: vcf_omit_support_reads
    type:
      - 'null'
      - boolean
    doc: By default, the vcf file has a column showing one or more supporting 
      reads for each variant. If set, the output vcf file will hide the 
      supporting reads for each variant.
    inputBinding:
      position: 101
      prefix: --vcf-omit-support-reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: output diagnostic information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: verbose_alignment
    type:
      - 'null'
      - boolean
    doc: output verbose information about the alignment process
    inputBinding:
      position: 101
      prefix: --verbose-alignment
  - id: verbose_reference
    type:
      - 'null'
      - boolean
    doc: output verbose information about the process of analyzing the reference
    inputBinding:
      position: 101
      prefix: --verbose-reference
  - id: verbosity_auto
    type:
      - 'null'
      - boolean
    doc: set verbosity flags dynamically and automatically based on the data and
      alignment
    inputBinding:
      position: 101
      prefix: --verbosity-auto
outputs:
  - id: out_mutations
    type:
      - 'null'
      - File
    doc: output file to generate listing the mutations of the queries compared 
      to the reference genome
    outputBinding:
      glob: $(inputs.out_mutations)
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: output file to generate containing a description of mutation counts by 
      position
    outputBinding:
      glob: $(inputs.out_vcf)
  - id: out_sam
    type:
      - 'null'
      - File
    doc: the output file in SAM format
    outputBinding:
      glob: $(inputs.out_sam)
  - id: out_refs_map_count
    type:
      - 'null'
      - File
    doc: the output file to summarize the number of reads mapped to each 
      combination of references
    outputBinding:
      glob: $(inputs.out_refs_map_count)
  - id: out_unaligned
    type:
      - 'null'
      - File
    doc: output file containing unaligned reads. Must have a .fasta or .fastq 
      extension
    outputBinding:
      glob: $(inputs.out_unaligned)
  - id: out_ancestor
    type:
      - 'null'
      - File
    doc: file to write our inferred ancestors. See also --no-infer-ancestors
    outputBinding:
      glob: $(inputs.out_ancestor)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/x-mapper:1.2.0--hdfd78af_0
