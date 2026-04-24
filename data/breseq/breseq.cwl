cwlVersion: v1.2
class: CommandLineTool
baseCommand: breseq
label: breseq
doc: "Run the breseq pipeline for predicting mutations from haploid microbial re-sequencing
  data.\n\nTool homepage: https://github.com/barricklab/breseq"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: FASTQ read files (which may be gzipped) are input as the last unnamed 
      argument(s).
    inputBinding:
      position: 1
  - id: aligned_sam
    type:
      - 'null'
      - boolean
    doc: "Input files are aligned SAM files, rather than FASTQ files. Junction prediction
      steps will be skipped. Be aware that breseq assumes: (1) Your SAM file is sorted
      such that all alignments for a given read are on consecutive lines. You can
      use 'samtools sort -n' if you are not sure that this is true for the output
      of your alignment program. (2) You EITHER have alignment scores as additional
      SAM fields with the form 'AS:i:n', where n is a positive integer and higher
      values indicate a better alignment OR it defaults to calculating an alignment
      score that is equal to the number of bases in the read minus the number of inserted
      bases, deleted bases, and soft clipped bases in the alignment to the reference.
      The default highly penalizes split-read matches (with CIGAR strings such as
      M35D303M65)."
    inputBinding:
      position: 102
      prefix: --aligned-sam
  - id: analysis_name
    type:
      - 'null'
      - string
    doc: Human-readable name of the analysis run for output
    inputBinding:
      position: 102
      prefix: --name
  - id: base_quality_cutoff
    type:
      - 'null'
      - int
    doc: Ignore bases with quality scores lower than this value
    inputBinding:
      position: 102
      prefix: --base-quality-cutoff
  - id: bowtie2_junction
    type:
      - 'null'
      - string
    doc: Settings for mapping criteria used in aligning reads to candidate 
      junctions.
    inputBinding:
      position: 102
      prefix: --bowtie2-junction
  - id: bowtie2_scoring
    type:
      - 'null'
      - string
    doc: All calls to bowtie2 must use the same commands for assigning scores to
      read alignments. Larger scores are assumed to be better by breseq. Each 
      call to bowtie2 has this option added to its command line.
    inputBinding:
      position: 102
      prefix: --bowtie2-scoring
  - id: bowtie2_stage1
    type:
      - 'null'
      - string
    doc: Settings for mapping criteria used for the stage 1 alignment. This step
      is normally meant for quickly aligning near-perfect matches.
    inputBinding:
      position: 102
      prefix: --bowtie2-stage1
  - id: bowtie2_stage2
    type:
      - 'null'
      - string
    doc: Settings for mapping criteria used for the stage 2 alignment. If set to
      the empty string "", then stage 2 alignment is skipped. This step is 
      normally meant for exhaustively mapping reads that were unmapped by stage 
      1.
    inputBinding:
      position: 102
      prefix: --bowtie2-stage2
  - id: brief_html_output
    type:
      - 'null'
      - boolean
    doc: Don't create detailed output files for evidence (no read alignments or 
      coverage plots)
    inputBinding:
      position: 102
      prefix: --brief-html-output
  - id: call_mutations_overlapping_mc
    type:
      - 'null'
      - boolean
    doc: If provided, don't ignore mutations predicted from RA evidence that 
      overlap MC evidence
    inputBinding:
      position: 102
      prefix: --call-mutations-overlapping-MC
  - id: cnv
    type:
      - 'null'
      - boolean
    doc: Do experimental copy number variation prediction
    inputBinding:
      position: 102
      prefix: --cnv
  - id: cnv_ignore_redundant
    type:
      - 'null'
      - boolean
    doc: Only consider non-redundant coverage when using cnv
    inputBinding:
      position: 102
      prefix: --cnv-ignore-redundant
  - id: cnv_tile_size
    type:
      - 'null'
      - int
    doc: Tile size for copy number variation prediction
    inputBinding:
      position: 102
      prefix: --cnv-tile-size
  - id: consensus_frequency_cutoff
    type:
      - 'null'
      - float
    doc: Only predict consensus mutations when the variant allele frequency is 
      above this value. (DEFAULT = consensus mode, 0.8; polymorphism mode, 0.8)
    inputBinding:
      position: 102
      prefix: --consensus-frequency-cutoff
  - id: consensus_minimum_total_coverage
    type:
      - 'null'
      - int
    doc: Only predict consensus mutations when at least this many reads total 
      are aligned to a genome position. (DEFAULT = consensus mode, 0; 
      polymorphism mode, 0)
    inputBinding:
      position: 102
      prefix: --consensus-minimum-total-coverage
  - id: consensus_minimum_total_coverage_each_strand
    type:
      - 'null'
      - int
    doc: Only predict consensus mutations when at least this many reads on each 
      strand are aligned to a genome position. (DEFAULT = consensus mode, 0; 
      polymorphism mode, 0)
    inputBinding:
      position: 102
      prefix: --consensus-minimum-total-coverage-each-strand
  - id: consensus_minimum_variant_coverage
    type:
      - 'null'
      - int
    doc: Only predict consensus mutations when at least this many reads support 
      the mutation. (DEFAULT = consensus mode, 0; polymorphism mode, 0)
    inputBinding:
      position: 102
      prefix: --consensus-minimum-variant-coverage
  - id: consensus_minimum_variant_coverage_each_strand
    type:
      - 'null'
      - int
    doc: Only predict consensus mutations when at least this many reads on each 
      strand support the mutation. (DEFAULT = consensus mode, 0; polymorphism 
      mode, 0)
    inputBinding:
      position: 102
      prefix: --consensus-minimum-variant-coverage-each-strand
  - id: consensus_reject_indel_homopolymer_length
    type:
      - 'null'
      - int
    doc: Reject insertion/deletion polymorphisms which could result from 
      expansion/contraction of homopolymer repeats with this length or greater 
      in the reference genome (0 = OFF) (DEFAULT = consensus mode, OFF; 
      polymorphism mode, OFF)
    inputBinding:
      position: 102
      prefix: --consensus-reject-indel-homopolymer-length
  - id: consensus_reject_surrounding_homopolymer_length
    type:
      - 'null'
      - int
    doc: Reject polymorphic base substitutions that create a homopolymer with 
      this many or more of one base in a row. The homopolymer must begin and end
      after the changed base. For example, TATTT->TTTTT would be rejected with a
      setting of 5, but ATTTT->TTTTT would not. (0 = OFF) (DEFAULT = consensus 
      mode, OFF; polymorphism mode, OFF)
    inputBinding:
      position: 102
      prefix: --consensus-reject-surrounding-homopolymer-length
  - id: consensus_score_cutoff
    type:
      - 'null'
      - int
    doc: Log10 E-value cutoff for consensus base substitutions and small indels
    inputBinding:
      position: 102
      prefix: --consensus-score-cutoff
  - id: contig_reference
    type:
      - 'null'
      - File
    doc: File containing reference sequences in GenBank, GFF3, or FASTA format. 
      The same coverage distribution will be fit to all of the reference 
      sequences in this file simultaneously. This is appropriate when they are 
      all contigs from a genome that should be present with the same copy 
      number. Use of this option will improve performance when there are many 
      contigs and especially when some are very short (≤1,000 bases).
    inputBinding:
      position: 102
      prefix: --contig-reference
  - id: deletion_coverage_propagation_cutoff
    type:
      - 'null'
      - int
    doc: Value for coverage above which MC ends stop. 0 = calculated from 
      coverage distribution
    inputBinding:
      position: 102
      prefix: --deletion-coverage-propagation-cutoff
  - id: deletion_coverage_seed_cutoff
    type:
      - 'null'
      - int
    doc: Value for coverage below which MC are seeded
    inputBinding:
      position: 102
      prefix: --deletion-coverage-seed-cutoff
  - id: genbank_field_for_seq_id
    type:
      - 'null'
      - string
    doc: Which GenBank header field will be used to assign sequence IDs. Valid 
      choices are LOCUS, ACCESSION, and VERSION. The default is to check those 
      fields, in that order, for the first one that exists. If you override the 
      default, you will need to use the converted reference file 
      (data/reference.gff) for further breseq and gdtools operations on breseq 
      output!
    inputBinding:
      position: 102
      prefix: --genbank-field-for-seq-id
  - id: header_genome_diff
    type:
      - 'null'
      - File
    doc: Include header information from this GenomeDiff file in output.gd
    inputBinding:
      position: 102
      prefix: --header-genome-diff
  - id: junction_alignment_pair_limit
    type:
      - 'null'
      - int
    doc: Only consider this many passed alignment pairs when creating candidate 
      junction sequences (0 = DO NOT LIMIT)
    inputBinding:
      position: 102
      prefix: --junction-alignment-pair-limit
  - id: junction_allow_suboptimal_matches
    type:
      - 'null'
      - boolean
    doc: Assign a read to the junction candidate with the most overall support 
      as long as its match to this junction is better than to any location in 
      the reference sequence, even if it matches a different junction candidate 
      better. This behavior was the default before v0.35.0. It will align more 
      reads to junctions but risks misassigning some reads to the wrong junction
      candidates. It is only recommended that you use this option in CONSENSUS 
      mode
    inputBinding:
      position: 102
      prefix: --junction-allow-suboptimal-matches
  - id: junction_candidate_length_factor
    type:
      - 'null'
      - float
    doc: Accept top-scoring junction candidates to test until their cumulative 
      length is this factor times the total reference sequence length (0 = DO 
      NOT LIMIT)
    inputBinding:
      position: 102
      prefix: --junction-candidate-length-factor
  - id: junction_debug
    type:
      - 'null'
      - boolean
    doc: Output additional junction debugging files
    inputBinding:
      position: 102
      prefix: --junction-debug
  - id: junction_indel_split_length
    type:
      - 'null'
      - int
    doc: Split read alignments on indels of this many or more bases. Indel 
      mutations of this length or longer will be predicted by JC evidence and 
      those that are shorter will be predicted from RA evience
    inputBinding:
      position: 102
      prefix: --junction-indel-split-length
  - id: junction_maximum_candidates
    type:
      - 'null'
      - int
    doc: Test no more than this many of the top-scoring junction candidates (0 =
      DO NOT LIMIT)
    inputBinding:
      position: 102
      prefix: --junction-maximum-candidates
  - id: junction_minimum_candidate_pos_hash_score
    type:
      - 'null'
      - int
    doc: Minimum number of distinct spanning read start positions required to 
      create a junction candidate for further testing
    inputBinding:
      position: 102
      prefix: --junction-minimum-candidate-pos-hash-score
  - id: junction_minimum_candidates
    type:
      - 'null'
      - int
    doc: Test at least this many of the top-scoring junction candidates, 
      regardless of their length
    inputBinding:
      position: 102
      prefix: --junction-minimum-candidates
  - id: junction_minimum_pos_hash_score
    type:
      - 'null'
      - int
    doc: Minimum number of distinct spanning read start positions required to 
      accept a junction (DEFAULT = consensus mode, 3; polymorphism mode, 3)
    inputBinding:
      position: 102
      prefix: --junction-minimum-pos-hash-score
  - id: junction_minimum_pr_no_read_start_per_position
    type:
      - 'null'
      - float
    doc: Minimum probablilty assigned that no mapped read will start at a given 
      position and strand for junction prediction
    inputBinding:
      position: 102
      prefix: --junction-minimum-pr-no-read-start-per-position
  - id: junction_minimum_side_match
    type:
      - 'null'
      - int
    doc: Minimum number of bases a read must extend past any overlap or 
      read-only sequence at the breakpoint of a junction on each side to count 
      as support for the junction (DEFAULT = consensus mode, 1; polymorphism 
      mode, 6)
    inputBinding:
      position: 102
      prefix: --junction-minimum-side-match
  - id: junction_only_reference
    type:
      - 'null'
      - type: array
        items: File
    doc: File containing reference sequences in GenBank, GFF3, or FASTA format. 
      These references are only used for calling junctions with other reference 
      sequences. An example of appropriate usage is including a transposon 
      sequence not present in a reference genome. Option may be provided 
      multiple times for multiple files.
    inputBinding:
      position: 102
      prefix: --junction-only-reference
  - id: junction_score_cutoff
    type:
      - 'null'
      - float
    doc: Maximum negative log10 probability of uneven coverage across a junction
      breakpoint to accept (0 = OFF)
    inputBinding:
      position: 102
      prefix: --junction-score-cutoff
  - id: keep_intermediates
    type:
      - 'null'
      - boolean
    doc: Do not delete intermediate files.
    inputBinding:
      position: 102
      prefix: --keep-intermediates
  - id: limit_fold_coverage
    type:
      - 'null'
      - float
    doc: Analyze a subset of the input FASTQ sequencing reads with enough bases 
      to provide this theoretical coverage of the reference sequences. A value 
      between 60 and 120 will usually speed up the analysis with no loss in 
      sensitivity for clonal samples. The actual coverage achieved will be 
      somewhat less because not all reads will map
    inputBinding:
      position: 102
      prefix: --limit-fold-coverage
  - id: long_read_distribute_remainder
    type:
      - 'null'
      - boolean
    doc: When splitting long reads, divide them into equal pieces that are less 
      than the split length. If this option is not chosen (the default), reads 
      will be split into chunks with exactly the split length and any remaining 
      bases after the last chunk will be ignored.
    inputBinding:
      position: 102
      prefix: --long-read-distribute-remainder
  - id: long_read_split_length
    type:
      - 'null'
      - int
    doc: Split input reads in a file marked as having long reads into pieces 
      that are at most this many bases long. Using values much larger than the 
      default for this parameter will likely degrade the speed and accuracy of 
      breseq because of how it performs mapping and analyzes split-read 
      alignments. Filters such as --read-min-length are applied to split reads. 
      (0 = OFF)
    inputBinding:
      position: 102
      prefix: --long-read-split-length
  - id: long_read_trigger_length
    type:
      - 'null'
      - int
    doc: Mark a file as containing long reads and enable read splitting if the 
      longest read has a length that is greater than or equal to this value. (0 
      = OFF)
    inputBinding:
      position: 102
      prefix: --long-read-trigger-length
  - id: max_displayed_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to display in the HTML output for an evidence 
      item
    inputBinding:
      position: 102
      prefix: --max-displayed-reads
  - id: maximum_read_mismatches
    type:
      - 'null'
      - int
    doc: Don't consider reads with this many or more bases or indels that are 
      different from the reference sequence. Unaligned bases at the end of a 
      read also count as mismatches. Unaligned bases at the beginning of the 
      read do NOT count as mismatches.
    inputBinding:
      position: 102
      prefix: --maximum-read-mismatches
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: Ignore alignments with less than this mapping quality (MQ) when calling
      mutations. MQ scores are equal to -10log10(P), where P is the probability 
      that the best alignment is not to the correct location in the reference 
      genome. The range of MQ scores returned by bowtie2 is 0 to 255.
    inputBinding:
      position: 102
      prefix: --minimum-mapping-quality
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Set options for nanopore data. Equivalent to 
      --consensus-reject-indel-homopolymer-length 4 
      --polymorphism-reject-indel-homopolymer-length 4 consensus/polymorphism 
      --polymorphism-no-indel --bowtie2-stage1 "--local -i S,1,0.25 --score-min 
      L,1,0.9 -k 2000" --bowtie2-stage2 "--local -i S,1,0.25 --score-min L,6,0.2
      -k 2000" . If you provide any of these options on their own, then they 
      will override these preset options.
    inputBinding:
      position: 102
      prefix: --nanopore
  - id: no_javascript
    type:
      - 'null'
      - boolean
    doc: Don't include javascript in the HTML output
    inputBinding:
      position: 102
      prefix: --no-javascript
  - id: no_junction_prediction
    type:
      - 'null'
      - boolean
    doc: Do not predict new sequence junctions
    inputBinding:
      position: 102
      prefix: --no-junction-prediction
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Number of processors to use in multithreaded steps
    inputBinding:
      position: 102
      prefix: --num-processors
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to breseq output
    inputBinding:
      position: 102
      prefix: --output
  - id: per_position_file
    type:
      - 'null'
      - boolean
    doc: Create additional file of per-position aligned bases
    inputBinding:
      position: 102
      prefix: --per-position-file
  - id: polymorphism_bias_cutoff
    type:
      - 'null'
      - float
    doc: P-value criterion for Fisher's exact test for strand bias AND K-S test 
      for quality score bias. (0 = OFF) (DEFAULT = consensus mode, OFF; 
      polymorphism mode, OFF)
    inputBinding:
      position: 102
      prefix: --polymorphism-bias-cutoff
  - id: polymorphism_frequency_cutoff
    type:
      - 'null'
      - float
    doc: Only predict polymorphisms when the minor variant allele frequency is 
      greater than this value. For example, a setting of 0.05 will reject all 
      polymorphisms with a non-reference frequency of <0.05, and any variants 
      with a non-reference frequency of ≥ 0.95 (which is 1 - 0.05) will be 
      rejected as polymorphisms and instead predicted to be consensus mutations 
      (DEFAULT = consensus mode, 0.2; polymorphism mode, 0.05)
    inputBinding:
      position: 102
      prefix: --polymorphism-frequency-cutoff
  - id: polymorphism_minimum_total_coverage
    type:
      - 'null'
      - int
    doc: Only predict polymorphisms when at least this many reads total are 
      aligned to a genome position. (DEFAULT = consensus mode, 0; polymorphism 
      mode, 0)
    inputBinding:
      position: 102
      prefix: --polymorphism-minimum-total-coverage
  - id: polymorphism_minimum_total_coverage_each_strand
    type:
      - 'null'
      - int
    doc: Only predict polymorphisms when at least this many reads on each strand
      are aligned to a genome position. (DEFAULT = consensus mode, 0; 
      polymorphism mode, 0)
    inputBinding:
      position: 102
      prefix: --polymorphism-minimum-total-coverage-each-strand
  - id: polymorphism_minimum_variant_coverage
    type:
      - 'null'
      - int
    doc: Only predict polymorphisms when at least this many reads support each 
      alternative allele. (DEFAULT = consensus mode, 0; polymorphism mode, 0)
    inputBinding:
      position: 102
      prefix: --polymorphism-minimum-variant-coverage
  - id: polymorphism_minimum_variant_coverage_each_strand
    type:
      - 'null'
      - int
    doc: Only predict polymorphisms when at least this many reads on each strand
      support each alternative allele. (DEFAULT = consensus mode, 0; 
      polymorphism mode, 2)
    inputBinding:
      position: 102
      prefix: --polymorphism-minimum-variant-coverage-each-strand
  - id: polymorphism_no_indels
    type:
      - 'null'
      - boolean
    doc: Do not predict insertion/deletion polymorphisms ≤50 bp from read 
      alignment or new junction evidence
    inputBinding:
      position: 102
      prefix: --polymorphism-no-indels
  - id: polymorphism_prediction
    type:
      - 'null'
      - boolean
    doc: The sample is not clonal. Predict polymorphic (mixed) mutations. 
      Setting this flag changes from CONSENSUS MODE (the default) to 
      POLYMORPHISM MODE
    inputBinding:
      position: 102
      prefix: --polymorphism-prediction
  - id: polymorphism_reject_indel_homopolymer_length
    type:
      - 'null'
      - int
    doc: Reject insertion/deletion polymorphisms which could result from 
      expansion/contraction of homopolymer repeats with this length or greater 
      in the reference genome (0 = OFF) (DEFAULT = consensus mode, OFF; 
      polymorphism mode, 3)
    inputBinding:
      position: 102
      prefix: --polymorphism-reject-indel-homopolymer-length
  - id: polymorphism_reject_surrounding_homopolymer_length
    type:
      - 'null'
      - int
    doc: Reject polymorphic base substitutions that create a homopolymer with 
      this many or more of one base in a row. The homopolymer must begin and end
      after the changed base. For example, TATTT->TTTTT would be rejected with a
      setting of 5, but ATTTT->TTTTT would not. (0 = OFF) (DEFAULT = consensus 
      mode, OFF; polymorphism mode, 5)
    inputBinding:
      position: 102
      prefix: --polymorphism-reject-surrounding-homopolymer-length
  - id: polymorphism_score_cutoff
    type:
      - 'null'
      - int
    doc: Log10 E-value cutoff for test of polymorphism vs no polymorphism 
      (DEFAULT = consensus mode, 10; polymorphism mode, 2)
    inputBinding:
      position: 102
      prefix: --polymorphism-score-cutoff
  - id: quality_score_trim
    type:
      - 'null'
      - boolean
    doc: Trim the ends of reads past any base with a quality score below 
      --base-quality-score-cutoff.
    inputBinding:
      position: 102
      prefix: --quality-score-trim
  - id: read_max_n_fraction
    type:
      - 'null'
      - float
    doc: Reads in the input FASTQ file in which this fraction or more of the 
      bases are uncalled as N will be ignored. (0 = OFF)
    inputBinding:
      position: 102
      prefix: --read-max-N-fraction
  - id: read_max_same_base_fraction
    type:
      - 'null'
      - float
    doc: Reads in the input FASTQ file in which this fraction or more of the 
      bases are the same will be ignored. (0 = OFF)
    inputBinding:
      position: 102
      prefix: --read-max-same-base-fraction
  - id: read_min_length
    type:
      - 'null'
      - int
    doc: Reads in the input FASTQ file that are shorter than this length will be
      ignored. (0 = OFF)
    inputBinding:
      position: 102
      prefix: --read-min-length
  - id: reference_files
    type:
      type: array
      items: File
    doc: File containing reference sequences in GenBank, GFF3, or FASTA format. 
      Option may be provided multiple times for multiple files
    inputBinding:
      position: 102
      prefix: --reference
  - id: require_match_fraction
    type:
      - 'null'
      - float
    doc: Only consider alignments that cover this fraction of a read
    inputBinding:
      position: 102
      prefix: --require-match-fraction
  - id: require_match_length
    type:
      - 'null'
      - int
    doc: Only consider alignments that cover this many bases of a read
    inputBinding:
      position: 102
      prefix: --require-match-length
  - id: skip_jc_prediction
    type:
      - 'null'
      - boolean
    doc: Skip generating new junction evidence.
    inputBinding:
      position: 102
      prefix: --skip-JC-prediction
  - id: skip_mc_prediction
    type:
      - 'null'
      - boolean
    doc: Skip generating missing coverage evidence.
    inputBinding:
      position: 102
      prefix: --skip-MC-prediction
  - id: skip_ra_mc_prediction
    type:
      - 'null'
      - boolean
    doc: Skip generating read alignment and missing coverage evidence.
    inputBinding:
      position: 102
      prefix: --skip-RA-MC-prediction
  - id: targeted_sequencing
    type:
      - 'null'
      - boolean
    doc: Reference sequences were targeted for ultra-deep sequencing (using 
      pull-downs or amplicons). Do not fit coverage distribution.
    inputBinding:
      position: 102
      prefix: --targeted-sequencing
  - id: user_evidence_gd
    type:
      - 'null'
      - File
    doc: User supplied Genome Diff file of JC and/or RA evidence items. The 
      breseq output will report the support for these sequence changes even if 
      they do not pass the normal filters for calling mutations in this sample.
    inputBinding:
      position: 102
      prefix: --user-evidence-gd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breseq:0.39.0--h077b44d_3
stdout: breseq.out
