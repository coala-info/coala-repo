cwlVersion: v1.2
class: CommandLineTool
baseCommand: verse
label: verse
doc: "Count reads mapped to features in an annotation file.\n\nTool homepage: https://github.com/OpenBMB/AgentVerse"
inputs:
  - id: input_file
    type: File
    doc: Give the name of input read file that contains the read mapping 
      results. Format of input file is automatically determined (SAM/BAM) If it 
      is paired-end data, the file MUST be name-sorted, otherwise the user MUST 
      specify -S, or use samtools to sort it by name.
    inputBinding:
      position: 1
  - id: annotation_file
    type: File
    doc: Give the name of the annotation file. The program currently only 
      supports GTF format.
    inputBinding:
      position: 102
      prefix: -a
  - id: assign_independently
    type:
      - 'null'
      - boolean
    doc: If specified, VERSE will assign reads to listed feature types 
      independently. This has the same effect as running VERSE separately for 
      each feature type, except that it only requires one run, thus is more 
      efficient.
    inputBinding:
      position: 102
      prefix: --assignIndependently
  - id: check_template_length
    type:
      - 'null'
      - boolean
    doc: If specified, template length (TLEN in SAM specification) will be 
      checked when assigning read pairs (templates) to genes. This option is 
      only applicable in paired-end mode. The distance thresholds should be 
      specified using -d and -D options.
    inputBinding:
      position: 102
      prefix: -P
  - id: count_both_ends_aligned_pairs_only
    type:
      - 'null'
      - boolean
    doc: If specified, only read pairs that have both ends successfully aligned 
      will be considered for summarization. This option is only applicable for 
      paired-end reads.
    inputBinding:
      position: 102
      prefix: -B
  - id: count_split_alignments_only
    type:
      - 'null'
      - boolean
    doc: If specified, only split alignments (CIGAR strings containing letter 
      `N') will be counted. All the other alignments will be ignored. An example
      of split alignments is the exon-spanning reads in RNA-seq data.
    inputBinding:
      position: 102
      prefix: --countSplitAlignmentsOnly
  - id: feature_type
    type:
      - 'null'
      - string
    doc: Specify the feature type. Only rows which have the matched feature type
      in the provided GTF annotation file will be included for read counting. 
      'exon' by default. Providing a list of feature types (e.g., -t 
      'exon;intron;mito') will automatically enter hierarchical_assign mode. If 
      the user wants to assign independently for each feature type, please 
      specify '--assignIndependently'. Use -Z to check the details.
    inputBinding:
      position: 102
      prefix: -t
  - id: gene_identifier
    type:
      - 'null'
      - string
    doc: Specify the gene_identifier attribute, which is normally 'gene_id' or 
      'gene_name'. 'gene_id' by default.
    inputBinding:
      position: 102
      prefix: -g
  - id: ignore_chimeric_pairs
    type:
      - 'null'
      - boolean
    doc: If specified, the chimeric read pairs (those that have their two ends 
      aligned to different chromosomes) will NOT be included for summarization. 
      This option is only applicable for paired-end data.
    inputBinding:
      position: 102
      prefix: -C
  - id: ignore_duplicates
    type:
      - 'null'
      - boolean
    doc: If specified, reads that were marked as duplicates will be ignored. Bit
      Ox400 in FLAG field of SAM/BAM file is used for identifying duplicate 
      reads. In paired end data, the entire read pair will be ignored if at 
      least one end is found to be a duplicate read.
    inputBinding:
      position: 102
      prefix: --ignoreDup
  - id: input_is_paired_end_but_not_name_sorted
    type:
      - 'null'
      - boolean
    doc: If the input file is paired-end data but not sorted by read name, this 
      option MUST be specified.
    inputBinding:
      position: 102
      prefix: -S
  - id: max_read_nonoverlap
    type:
      - 'null'
      - int
    doc: Specify the maximum number of non-overlapped bases a read can have. A 
      read is considered no_feature if its number of non-overlapped bases 
      exceeds this threshold. This option is not useful in strict mode since it 
      requires the assigned feature to overlap every base of the read.
    inputBinding:
      position: 102
      prefix: --maxReadNonoverlap
  - id: max_template_length
    type:
      - 'null'
      - int
    doc: Maximum template(read pair) length, 600 by default.
    inputBinding:
      position: 102
      prefix: -D
  - id: min_dif_ambiguous
    type:
      - 'null'
      - int
    doc: This option can only be used in VERSE-cover_length mode. When the read 
      or the read pair hits more than one genes, the number of bases overlapped 
      by each gene will be calculated. If the covered_length difference between 
      the most covered gene and the second most covered gene is smaller than 
      this specified value, the read will be set ambiguous. 1 base difference by
      default.
    inputBinding:
      position: 102
      prefix: --minDifAmbiguous
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: The minimum mapping quality score a read must satisfy in order to be 
      counted. For paired-end reads, at least one end should satisfy this 
      criteria. 0 by default.
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_read_overlap
    type:
      - 'null'
      - int
    doc: Specify the minimum number of overlapped bases required to assign a 
      read to a feature. 1 by default.
    inputBinding:
      position: 102
      prefix: --minReadOverlap
  - id: min_template_length
    type:
      - 'null'
      - int
    doc: Minimum template(read pair) length, 50 by default.
    inputBinding:
      position: 102
      prefix: -d
  - id: multithread_decompress
    type:
      - 'null'
      - boolean
    doc: BAM files generated with SAMTools or STAR after year 2013 has a slight 
      format change which allows multithreaded decompression. BAM processing 
      will be faster if this option is specifed and multiple core is used.
    inputBinding:
      position: 102
      prefix: --multithreadDecompress
  - id: nonempty_modified
    type:
      - 'null'
      - boolean
    doc: This option can only be used in intersection_ nonempty mode. In cases 
      where HTSeq would assign multi-hit reads to no_feature, VERSE will assign 
      those to ambiguous.
    inputBinding:
      position: 102
      prefix: --nonemptyModified
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads used for read assignment. 1 by default. Note that 
      when running, VERSE will initiate one main thread and at least one helper 
      thread for read assignment. This option specifies the number of helper 
      threads.
    inputBinding:
      position: 102
      prefix: -T
  - id: output_gene_length
    type:
      - 'null'
      - boolean
    doc: Output the gene length. This length is feature_type specific, which 
      means the length in an exon_count file will be the total exon length of 
      each gene, the length in an intron_count file will be the total intron 
      length, etc.
    inputBinding:
      position: 102
      prefix: -l
  - id: output_read_assignment_details
    type:
      - 'null'
      - boolean
    doc: Output read assignment details for each read/read pairs. The details 
      will be saved to a tab-delimited file that contains five columns including
      read name, status(assigned or the reason if not assigned), feature type 
      and assigned gene name.
    inputBinding:
      position: 102
      prefix: -R
  - id: read2pos
    type:
      - 'null'
      - string
    doc: The read is reduced to its 5' most base or 3' most base. Read 
      summarization is then performed based on the single base which the read is
      reduced to.
    inputBinding:
      position: 102
      prefix: --read2pos
  - id: read_extension_3
    type:
      - 'null'
      - int
    doc: Reads are extended upstream by <int> bases from their 3' end.
    inputBinding:
      position: 102
      prefix: --readExtension3
  - id: read_extension_5
    type:
      - 'null'
      - int
    doc: Reads are extended upstream by <int> bases from their 5' end.
    inputBinding:
      position: 102
      prefix: --readExtension5
  - id: running_mode
    type:
      - 'null'
      - int
    doc: "The Running Mode: 0 by default (featureCounts), 1 (HTSeq-Union), 2 (HTSeq-Intersection_strict),
      3 (HTSeq-Intersection_nonempty), 4 (Union_strict), 5 (Cover_length). Please
      refer to the manual or use '-Z' to check the details of each mode."
    inputBinding:
      position: 102
      prefix: -z
  - id: show_details
    type:
      - 'null'
      - boolean
    doc: Show details about the running mode or scheme.
    inputBinding:
      position: 102
      prefix: -Z
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: If specified, VERSE will assume the input is single-end data, and 
      assign every reads individually. If this is not specified(default), the 
      input will be treated as paired-end data. The 'missing mate' count will 
      show how many reads are not in pairs. VERSE can correctly assign 
      single-end data in paired-end mode, but it will take longer and the reads 
      will all be counted as missing mates. So it is recommended to specify this
      if the user knows it is single-end.
    inputBinding:
      position: 102
      prefix: --singleEnd
  - id: strand_specific
    type:
      - 'null'
      - int
    doc: 'Indicate if strand-specific read counting should be performed. It has three
      possible values: 0 (unstranded), 1 (stranded) and 2 (reversely stranded). 0
      by default.'
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_file
    type: File
    doc: Give the general name of the output file, e.g., 'Sample_A'. The summary
      file will be named 'Sample_A.summary.txt.' The file containing gene counts
      will be named 'Sample_A.exon.txt', 'Sample_A.intron.txt', etc.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verse:0.1.5--h577a1d6_9
