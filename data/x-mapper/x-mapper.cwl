cwlVersion: v1.2
class: CommandLineTool
baseCommand: x-mapper
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
  - id: extend_indel_penalty
    type:
      - 'null'
      - float
    doc: the penalty of an extension to an existing insertion or deletion
    inputBinding:
      position: 101
      prefix: --extend-indel-penalty
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
  - id: snp_penalty
    type:
      - 'null'
      - float
    doc: the penalty of a point mutation
    inputBinding:
      position: 101
      prefix: --snp-penalty
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
      position: 110
      prefix: --vcf-exclude-non-mutations
  - id: vcf_omit_support_reads
    type:
      - 'null'
      - boolean
    doc: By default, the vcf file has a column showing one or more supporting 
      reads for each variant. If set, the output vcf file will hide the 
      supporting reads for each variant.
    inputBinding:
      position: 110
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
  - id: out_ancestor_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --out-ancestor
  - id: out_mutations_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 106
      prefix: --out-mutations
  - id: out_refs_map_count_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --out-refs-map-count
  - id: out_sam_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --out-sam
  - id: out_unaligned_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 105
      prefix: --out-unaligned
  - id: out_vcf_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 108
      prefix: --out-vcf
  - id: paired_queries
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina-style paired-end reads to align to the reference. Give two files
      (<file1> <file2>). For each read <r1> in <file1> and the corresponding <r2>
      in <file2>, the alignment position of <r1> is expected to be slightly before
      the alignment position of the reverse complement of <r2>.
    inputBinding:
      position: 99
      prefix: --paired-queries
  - id: spacing
    type:
      - 'null'
      - type: array
        items: int
    doc: '<expected> <distancePerPenalty> (default 100 50). Any query alignment whose
      inner distance deviates from <expected> has an additional penalty added, equal
      to the difference divided by <distancePerPenalty>.'
    inputBinding:
      position: 100
      prefix: --spacing
  - id: queries
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --queries
    doc: the reads to align to the reference. Should be in .fastq or .fasta format.
      Each file gets its own --queries.
    inputBinding:
      position: 101
  - id: reference
    type:
      type: array
      items: File
      inputBinding:
        prefix: --reference
    doc: the reference to use. Should be in .fasta/.fa/.fna or .fastq/.fq format
      or a .gz of one of those formats. Each file gets its own --reference.
    inputBinding:
      position: 101
  - id: mutations_snp_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-mutations output) <min total depth> <min supporting depth fraction>: minimum total depth and
      supporting depth fraction required at a position to report the mutation.'
    inputBinding:
      position: 107
      prefix: --snp-threshold
  - id: vcf_snp_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-vcf output) <min total depth> <min supporting depth fraction>: minimum total depth and
      supporting depth fraction required at a position to report the mutation.'
    inputBinding:
      position: 109
      prefix: --snp-threshold
  - id: mutations_indel_start_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-mutations output) <min total depth> <min supporting depth fraction> required to report the
      start of an insertion or deletion.'
    inputBinding:
      position: 107
      prefix: --indel-start-threshold
  - id: vcf_indel_start_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-vcf output) <min total depth> <min supporting depth fraction> required to report the
      start of an insertion or deletion.'
    inputBinding:
      position: 109
      prefix: --indel-start-threshold
  - id: mutations_indel_continue_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-mutations output) <min total depth> <min supporting depth fraction> required to report a
      continuation of an insertion or deletion.'
    inputBinding:
      position: 107
      prefix: --indel-continue-threshold
  - id: vcf_indel_continue_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-vcf output) <min total depth> <min supporting depth fraction> required to report a
      continuation of an insertion or deletion.'
    inputBinding:
      position: 109
      prefix: --indel-continue-threshold
  - id: mutations_indel_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-mutations output) Alias for --indel-start-threshold and --indel-continue-threshold: <min
      total depth> <min supporting depth fraction>.'
    inputBinding:
      position: 107
      prefix: --indel-threshold
  - id: vcf_indel_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: '(for the --out-vcf output) Alias for --indel-start-threshold and --indel-continue-threshold: <min
      total depth> <min supporting depth fraction>.'
    inputBinding:
      position: 109
      prefix: --indel-threshold
  - id: mutations_distinguish_query_ends
    type:
      - 'null'
      - float
    doc: (for the --out-mutations output) In the output vcf file, we separately display which queries aligned at 
      each position with <fraction> of the end of the query and which didn't.
    inputBinding:
      position: 107
      prefix: --distinguish-query-ends
  - id: vcf_distinguish_query_ends
    type:
      - 'null'
      - float
    doc: (for the --out-vcf output) In the output vcf file, we separately display which queries aligned at 
      each position with <fraction> of the end of the query and which didn't.
    inputBinding:
      position: 109
      prefix: --distinguish-query-ends
outputs:
  - id: out_mutations
    type:
      - 'null'
      - File
    doc: output file to generate listing the mutations of the queries compared 
      to the reference genome
    outputBinding:
      glob: $(inputs.out_mutations_path)
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: output file to generate containing a description of mutation counts by 
      position
    outputBinding:
      glob: $(inputs.out_vcf_path)
  - id: out_sam
    type:
      - 'null'
      - File
    doc: the output file in SAM format
    outputBinding:
      glob: $(inputs.out_sam_path)
  - id: out_refs_map_count
    type:
      - 'null'
      - File
    doc: the output file to summarize the number of reads mapped to each 
      combination of references
    outputBinding:
      glob: $(inputs.out_refs_map_count_path)
  - id: out_unaligned
    type:
      - 'null'
      - File
    doc: output file containing unaligned reads. Must have a .fasta or .fastq 
      extension
    outputBinding:
      glob: $(inputs.out_unaligned_path)
  - id: out_ancestor
    type:
      - 'null'
      - File
    doc: file to write our inferred ancestors. See also --no-infer-ancestors
    outputBinding:
      glob: $(inputs.out_ancestor_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/x-mapper:1.2.0--hdfd78af_0
