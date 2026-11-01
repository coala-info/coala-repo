cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FilterMutectCalls
label: gatk_FilterMutectCalls
doc: 'Filter somatic SNVs and indels called by Mutect2


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: output
  type: string
  doc: The output filtered VCF file
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
  inputBinding:
    position: 1
    prefix: --reference
- id: variant
  type: File
  doc: A VCF file containing variants
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --variant
- id: add_output_sam_program_record
  type:
  - 'null'
  - string
  doc: If true, adds a PG tag to created SAM/BAM/CRAM files. (true or false)
  inputBinding:
    position: 1
    prefix: --add-output-sam-program-record
- id: add_output_vcf_command_line
  type:
  - 'null'
  - string
  doc: If true, adds a command line header line to created VCF files. (true or false)
  inputBinding:
    position: 1
    prefix: --add-output-vcf-command-line
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 1
- id: cloud_index_prefetch_buffer
  type:
  - 'null'
  - int
  doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable). Defaults to cloudPrefetchBuffer if
    unset.
  inputBinding:
    position: 1
    prefix: --cloud-index-prefetch-buffer
- id: cloud_prefetch_buffer
  type:
  - 'null'
  - int
  doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable).
  inputBinding:
    position: 1
    prefix: --cloud-prefetch-buffer
- id: contamination_estimate
  type:
  - 'null'
  - double
  doc: Estimate of contamination.
  inputBinding:
    position: 1
    prefix: --contamination-estimate
- id: contamination_table
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --contamination-table
  doc: Tables containing contamination information.
  inputBinding:
    position: 1
- id: create_output_bam_index
  type:
  - 'null'
  - string
  doc: If true, create a BAM/CRAM index when writing a coordinate-sorted BAM/CRAM file. (true or false)
  inputBinding:
    position: 1
    prefix: --create-output-bam-index
- id: create_output_bam_md5
  type:
  - 'null'
  - boolean
  doc: If true, create a MD5 digest for any BAM/SAM/CRAM file created
  inputBinding:
    position: 1
    prefix: --create-output-bam-md5
- id: create_output_variant_index
  type:
  - 'null'
  - string
  doc: If true, create a VCF index when writing a coordinate-sorted VCF file. (true or false)
  inputBinding:
    position: 1
    prefix: --create-output-variant-index
- id: create_output_variant_md5
  type:
  - 'null'
  - boolean
  doc: If true, create a a MD5 digest any VCF file created.
  inputBinding:
    position: 1
    prefix: --create-output-variant-md5
- id: disable_bam_index_caching
  type:
  - 'null'
  - boolean
  doc: If true, don't cache bam indexes, this will reduce memory requirements but may harm performance
    if many intervals are specified. Caching is automatically disabled if there are no intervals specified.
  inputBinding:
    position: 1
    prefix: --disable-bam-index-caching
- id: disable_read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --disable-read-filter
  doc: Read filters to be disabled before analysis
  inputBinding:
    position: 1
- id: disable_sequence_dictionary_validation
  type:
  - 'null'
  - boolean
  doc: If specified, do not check the sequence dictionaries from our inputs for compatibility. Use at
    your own risk!
  inputBinding:
    position: 1
    prefix: --disable-sequence-dictionary-validation
- id: distance_on_haplotype
  type:
  - 'null'
  - int
  doc: On second filtering pass, variants with same PGT and PID tags as a filtered variant within this
    distance are filtered.
  inputBinding:
    position: 1
    prefix: --distance-on-haplotype
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: f_score_beta
  type:
  - 'null'
  - double
  doc: F score beta, the relative weight of recall to precision, used if OPTIMAL_F_SCORE strategy is chosen
  inputBinding:
    position: 1
    prefix: --f-score-beta
- id: false_discovery_rate
  type:
  - 'null'
  - double
  doc: Maximum false discovery rate allowed if FALSE_DISCOVERY_RATE threshold strategy is chosen
  inputBinding:
    position: 1
    prefix: --false-discovery-rate
- id: filtering_stats
  type:
  - 'null'
  - string
  doc: The output filtering stats file
  inputBinding:
    position: 1
    prefix: --filtering-stats
- id: gatk_config_file
  type:
  - 'null'
  - File
  doc: A configuration file to use with the GATK.
  inputBinding:
    position: 1
    prefix: --gatk-config-file
- id: gcs_max_retries
  type:
  - 'null'
  - int
  doc: If the GCS bucket channel errors out, how many times it will attempt to re-initiate the connection
  inputBinding:
    position: 1
    prefix: --gcs-max-retries
- id: gcs_project_for_requester_pays
  type:
  - 'null'
  - string
  doc: Project to bill when accessing "requester pays" buckets. If unset, these buckets cannot be accessed.
    User must have storage.buckets.get permission on the bucket being accessed.
  inputBinding:
    position: 1
    prefix: --gcs-project-for-requester-pays
- id: initial_threshold
  type:
  - 'null'
  - double
  doc: Initial artifact probability threshold used in first iteration
  inputBinding:
    position: 1
    prefix: --initial-threshold
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
  inputBinding:
    position: 1
- id: interval_exclusion_padding
  type:
  - 'null'
  - int
  doc: Amount of padding (in bp) to add to each interval you are excluding.
  inputBinding:
    position: 1
    prefix: --interval-exclusion-padding
- id: interval_merging_rule
  type:
  - 'null'
  - string
  doc: Interval merging rule for abutting intervals
  inputBinding:
    position: 1
    prefix: --interval-merging-rule
- id: interval_padding
  type:
  - 'null'
  - int
  doc: Amount of padding (in bp) to add to each interval you are including.
  inputBinding:
    position: 1
    prefix: --interval-padding
- id: interval_set_rule
  type:
  - 'null'
  - string
  doc: Set merging approach to use for combining interval inputs
  inputBinding:
    position: 1
    prefix: --interval-set-rule
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: inverted_read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --inverted-read-filter
  doc: Inverted (with flipped acceptance/failure conditions) read filters applied before analysis (after
    regular read filters).
  inputBinding:
    position: 1
- id: lenient
  type:
  - 'null'
  - boolean
  doc: Lenient processing of VCF files
  inputBinding:
    position: 1
    prefix: --lenient
- id: log_artifact_prior
  type:
  - 'null'
  - double
  doc: Initial ln prior probability that a called site is not a technical artifact
  inputBinding:
    position: 1
    prefix: --log-artifact-prior
- id: log_indel_prior
  type:
  - 'null'
  - double
  doc: Initial ln prior probability that a site has a somatic indel
  inputBinding:
    position: 1
    prefix: --log-indel-prior
- id: log_snv_prior
  type:
  - 'null'
  - double
  doc: Initial ln prior probability that a site has a somatic SNV
  inputBinding:
    position: 1
    prefix: --log-snv-prior
- id: long_indel_length
  type:
  - 'null'
  - int
  doc: Indels of this length or greater are treated specially by the mapping quality filter.
  inputBinding:
    position: 1
    prefix: --long-indel-length
- id: max_alt_allele_count
  type:
  - 'null'
  - int
  doc: Maximum alt alleles per site.
  inputBinding:
    position: 1
    prefix: --max-alt-allele-count
- id: max_events_in_haplotype
  type:
  - 'null'
  - int
  doc: Maximum number of non-germline events in a variant allele's best haplotype.
  inputBinding:
    position: 1
    prefix: --max-events-in-haplotype
- id: max_events_in_region
  type:
  - 'null'
  - int
  doc: Maximum number of non-germline events in a single assembly region. Filter all variants if exceeded.
  inputBinding:
    position: 1
    prefix: --max-events-in-region
- id: max_median_fragment_length_difference
  type:
  - 'null'
  - int
  doc: Maximum difference between median alt and ref fragment lengths
  inputBinding:
    position: 1
    prefix: --max-median-fragment-length-difference
- id: max_n_ratio
  type:
  - 'null'
  - double
  doc: Maximum fraction of non-ref bases in the pileup that are N (unknown)
  inputBinding:
    position: 1
    prefix: --max-n-ratio
- id: max_variants_per_shard
  type:
  - 'null'
  - int
  doc: If non-zero, partitions VCF output into shards, each containing up to the given number of records.
  inputBinding:
    position: 1
    prefix: --max-variants-per-shard
- id: microbial_mode
  type:
  - 'null'
  - boolean
  doc: Set filters to microbial defaults
  inputBinding:
    position: 1
    prefix: --microbial-mode
- id: min_allele_fraction
  type:
  - 'null'
  - double
  doc: Minimum allele fraction required
  inputBinding:
    position: 1
    prefix: --min-allele-fraction
- id: min_median_base_quality
  type:
  - 'null'
  - int
  doc: Minimum median base quality of alt reads
  inputBinding:
    position: 1
    prefix: --min-median-base-quality
- id: min_median_mapping_quality
  type:
  - 'null'
  - int
  doc: Minimum median mapping quality of alt reads
  inputBinding:
    position: 1
    prefix: --min-median-mapping-quality
- id: min_median_read_position
  type:
  - 'null'
  - int
  doc: Minimum median distance of variants from the end of reads
  inputBinding:
    position: 1
    prefix: --min-median-read-position
- id: min_reads_per_strand
  type:
  - 'null'
  - int
  doc: Minimum alt reads required on both forward and reverse strands
  inputBinding:
    position: 1
    prefix: --min-reads-per-strand
- id: min_slippage_length
  type:
  - 'null'
  - int
  doc: Minimum number of reference bases in an STR to suspect polymerase slippage
  inputBinding:
    position: 1
    prefix: --min-slippage-length
- id: mitochondria_mode
  type:
  - 'null'
  - boolean
  doc: Set filters to mitochondrial defaults
  inputBinding:
    position: 1
    prefix: --mitochondria-mode
- id: normal_p_value_threshold
  type:
  - 'null'
  - double
  doc: P value threshold for normal artifact filter
  inputBinding:
    position: 1
    prefix: --normal-p-value-threshold
- id: orientation_bias_artifact_priors
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --orientation-bias-artifact-priors
  doc: One or more .tar.gz files containing tables of prior artifact probabilities for the read orientation
    filter model, one table per tumor sample
  inputBinding:
    position: 1
- id: output_cram_version
  type:
  - 'null'
  - string
  doc: The CRAM version ('3.0' or '3.1') to write for CRAM output. Ignored for BAM/SAM output. Note that
    CRAM 3.1 (the default) cannot be read by tools that only support CRAM 3.0.
  inputBinding:
    position: 1
    prefix: --output-cram-version
- id: pcr_slippage_rate
  type:
  - 'null'
  - double
  doc: The frequency of polymerase slippage in contexts where it is suspected
  inputBinding:
    position: 1
    prefix: --pcr-slippage-rate
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 1
    prefix: --QUIET
- id: read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-filter
  doc: Read filters to be applied before analysis
  inputBinding:
    position: 1
- id: read_index
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --read-index
  doc: Indices to use for the read inputs. If specified, an index must be provided for every read input
    and in the same order as the read inputs. If this argument is not specified, the path to the index
    for each input will be inferred automatically.
  inputBinding:
    position: 1
- id: read_validation_stringency
  type:
  - 'null'
  - string
  doc: Validation stringency for all SAM/BAM/CRAM/SRA files read by this program. The default stringency
    value SILENT can improve performance when processing a BAM file in which variable-length data (read,
    qualities, tags) do not otherwise need to be decoded.
  inputBinding:
    position: 1
    prefix: --read-validation-stringency
- id: seconds_between_progress_updates
  type:
  - 'null'
  - double
  doc: Output traversal statistics every time this many seconds elapse
  inputBinding:
    position: 1
    prefix: --seconds-between-progress-updates
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary. Must be a .dict
    file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: sites_only_vcf_output
  type:
  - 'null'
  - boolean
  doc: If true, don't emit genotype fields when writing vcf file output.
  inputBinding:
    position: 1
    prefix: --sites-only-vcf-output
- id: stats
  type:
  - 'null'
  - File
  doc: The Mutect stats file output by Mutect2
  inputBinding:
    position: 1
    prefix: --stats
- id: threshold_strategy
  type:
  - 'null'
  - string
  doc: The method for optimizing the posterior probability threshold
  inputBinding:
    position: 1
    prefix: --threshold-strategy
- id: tmp_dir
  type:
  - 'null'
  - string
  doc: Temp directory to use.
  inputBinding:
    position: 1
    prefix: --tmp-dir
- id: tumor_segmentation
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --tumor-segmentation
  doc: Tables containing tumor segments' minor allele fractions for germline hets emitted by CalculateContamination
  inputBinding:
    position: 1
- id: unique_alt_read_count
  type:
  - 'null'
  - int
  doc: Minimum unique (i.e. deduplicated) reads supporting the alternate allele
  inputBinding:
    position: 1
    prefix: --unique-alt-read-count
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
  inputBinding:
    position: 1
    prefix: --use-jdk-deflater
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Whether to use the JdkInflater (as opposed to IntelInflater)
  inputBinding:
    position: 1
    prefix: --use-jdk-inflater
- id: verbosity
  type:
  - 'null'
  - string
  doc: Control verbosity of logging.
  inputBinding:
    position: 1
    prefix: --verbosity
- id: disable_tool_default_read_filters
  type:
  - 'null'
  - boolean
  doc: 'Disable all tool default read filters (WARNING: many tools will not function correctly without
    their default read filters on)'
  inputBinding:
    position: 1
    prefix: --disable-tool-default-read-filters
- id: variant_output_filtering
  type:
  - 'null'
  - string
  doc: Restrict the output variants to ones that match the specified intervals according to the specified
    matching mode.
  inputBinding:
    position: 1
    prefix: --variant-output-filtering
- id: ambig_filter_bases
  type:
  - 'null'
  - int
  doc: Threshold number of ambiguous bases. If null, uses threshold fraction; otherwise, overrides threshold
    fraction.
  inputBinding:
    position: 1
    prefix: --ambig-filter-bases
- id: ambig_filter_frac
  type:
  - 'null'
  - double
  doc: Threshold fraction of ambiguous bases
  inputBinding:
    position: 1
    prefix: --ambig-filter-frac
- id: max_clipped_bases
  type:
  - 'null'
  - int
  doc: Maximum number of clipped bases on either end of a given read
  inputBinding:
    position: 1
    prefix: --max-clipped-bases
- id: read_filter_max_hmer
  type:
  - 'null'
  - int
  doc: maxHmer to use for testing in the filter
  inputBinding:
    position: 1
    prefix: --read-filter-max-hmer
- id: max_fragment_length
  type:
  - 'null'
  - int
  doc: Maximum length of fragment (insert size)
  inputBinding:
    position: 1
    prefix: --max-fragment-length
- id: min_fragment_length
  type:
  - 'null'
  - int
  doc: Minimum length of fragment (insert size)
  inputBinding:
    position: 1
    prefix: --min-fragment-length
- id: keep_intervals
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --keep-intervals
  doc: One or more genomic intervals to keep
  inputBinding:
    position: 1
- id: read_filter_expression
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-filter-expression
  doc: One or more JEXL expressions used to filter
  inputBinding:
    position: 1
- id: library
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --library
  doc: Name of the library to keep
  inputBinding:
    position: 1
- id: maximum_mapping_quality
  type:
  - 'null'
  - int
  doc: Maximum mapping quality to keep (inclusive)
  inputBinding:
    position: 1
    prefix: --maximum-mapping-quality
- id: minimum_mapping_quality
  type:
  - 'null'
  - int
  doc: Minimum mapping quality to keep (inclusive)
  inputBinding:
    position: 1
    prefix: --minimum-mapping-quality
- id: mate_too_distant_length
  type:
  - 'null'
  - int
  doc: Minimum start location difference at which mapped mates are considered distant
  inputBinding:
    position: 1
    prefix: --mate-too-distant-length
- id: dont_require_soft_clips_both_ends
  type:
  - 'null'
  - boolean
  doc: Allow a read to be filtered out based on having only 1 soft-clipped block. By default, both ends
    must have a soft-clipped block, setting this flag requires only 1 soft-clipped block
  inputBinding:
    position: 1
    prefix: --dont-require-soft-clips-both-ends
- id: filter_too_short
  type:
  - 'null'
  - int
  doc: Minimum number of aligned bases
  inputBinding:
    position: 1
    prefix: --filter-too-short
- id: platform_filter_name
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --platform-filter-name
  doc: Platform attribute (PL) to match
  inputBinding:
    position: 1
- id: black_listed_lanes
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --black-listed-lanes
  doc: Platform unit (PU) to filter out
  inputBinding:
    position: 1
- id: read_group_black_list
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-group-black-list
  doc: A read group filter expression in the form "attribute:value", where "attribute" is a two character
    read group attribute such as "RG" or "PU".
  inputBinding:
    position: 1
- id: keep_read_group
  type:
  - 'null'
  - string
  doc: The name of the read group to keep
  inputBinding:
    position: 1
    prefix: --keep-read-group
- id: max_read_length
  type:
  - 'null'
  - int
  doc: Keep only reads with length at most equal to the specified value
  inputBinding:
    position: 1
    prefix: --max-read-length
- id: min_read_length
  type:
  - 'null'
  - int
  doc: Keep only reads with length at least equal to the specified value
  inputBinding:
    position: 1
    prefix: --min-read-length
- id: read_name
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-name
  doc: Keep only reads with this read name
  inputBinding:
    position: 1
- id: keep_reverse_strand_only
  type:
  - 'null'
  - boolean
  doc: Keep only reads on the reverse strand
  inputBinding:
    position: 1
    prefix: --keep-reverse-strand-only
- id: read_filter_tag
  type:
  - 'null'
  - string
  doc: Look for this tag in read
  inputBinding:
    position: 1
    prefix: --read-filter-tag
- id: read_filter_tag_comp
  type:
  - 'null'
  - float
  doc: Compare value in tag to this value
  inputBinding:
    position: 1
    prefix: --read-filter-tag-comp
- id: read_filter_tag_op
  type:
  - 'null'
  - string
  doc: Compare value in tag to value with this operator. If T is the value in the tag, OP is the operation
    provided, and V is the value in read-filter-tag, then the read will pass the filter iff T OP V is
    true.
  inputBinding:
    position: 1
    prefix: --read-filter-tag-op
- id: sample
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --sample
  doc: The name of the sample(s) to keep, filtering out all others
  inputBinding:
    position: 1
- id: max_soft_clipped_leading_trailing_ratio
  type:
  - 'null'
  - double
  doc: Threshold ratio of soft clipped bases (leading / trailing the cigar string) to total bases in read
    for read to be filtered.
  inputBinding:
    position: 1
    prefix: --max-soft-clipped-leading-trailing-ratio
- id: max_soft_clipped_ratio
  type:
  - 'null'
  - double
  doc: Threshold ratio of soft clipped bases (anywhere in the cigar string) to total bases in read for
    read to be filtered.
  inputBinding:
    position: 1
    prefix: --max-soft-clipped-ratio
outputs:
- id: output_file
  type: File
  doc: The output filtered VCF file
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: filtering_stats_file
  type:
  - 'null'
  - File
  doc: The output filtering stats file
  outputBinding:
    glob: $(inputs.filtering_stats)
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
