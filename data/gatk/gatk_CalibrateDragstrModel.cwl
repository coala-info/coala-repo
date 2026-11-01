cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CalibrateDragstrModel
label: gatk_CalibrateDragstrModel
doc: 'estimates the parameters for the DRAGstr model for the input sample using the output of the ComposeSTRTable
  tool


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: input
  type:
    type: array
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
- id: output
  type: string
  doc: where to write the parameter output file.
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
- id: str_table_path
  type: File
  doc: location of the zip that contains the sampling sites for the reference
  inputBinding:
    position: 1
    prefix: --str-table-path
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
- id: api_mono_threshold
  type:
  - 'null'
  - int
  doc: Maximum drop allowed in the API parameter within a period between consecutive repeat length values
    in Phred scale
  inputBinding:
    position: 1
    prefix: --api-mono-threshold
- id: api_values
  type:
  - 'null'
  - string
  doc: 'Possible prior probabilities for the heterozygous indel call for the DRAGstr model parameter esimation.
    These are expressed in Phred scaled values with the following format: start:step:end. For example
    the default ''10:1.0:50'' indicate the sequence starting at 10 finishing at 50 sampled at 1.0 intervals.'
  inputBinding:
    position: 1
    prefix: --api-values
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
- id: debug_sites_output
  type:
  - 'null'
  - string
  doc: table with information gather on the samples sites. Includes what sites were downsampled, disqualified
    or accepted for parameter estimation
  inputBinding:
    position: 1
    prefix: --debug-sites-output
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
- id: down_sample_size
  type:
  - 'null'
  - int
  doc: Targeted maximum number of cases per combination period repeat count, the larger the more precise
    but also the slower estimation.
  inputBinding:
    position: 1
    prefix: --down-sample-size
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
- id: force_estimation
  type:
  - 'null'
  - boolean
  doc: for testing purpose only; force parameter estimation even with few datapoints available
  inputBinding:
    position: 1
    prefix: --force-estimation
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
- id: gop_values
  type:
  - 'null'
  - string
  doc: 'Possible values for the gop parmeterThese are expressed in Phred scaled values with the following
    format: start:step:end. For example the default ''10:1.0:50'' indicate the sequence starting at 10
    finishing at 50 sampled at 1.0 intervals.'
  inputBinding:
    position: 1
    prefix: --gop-values
- id: gp_values
  type:
  - 'null'
  - string
  doc: 'Possible Gap-Penalty values for the DRAGstr model parameter esimation. These are expressed in
    Phred scaled values with the following format: start:step:end. For example the default ''10:1.0:50''
    indicate the sequence starting at 10 finishing at 50 sampled at 1.0 intervals.'
  inputBinding:
    position: 1
    prefix: --gp-values
- id: het_to_hom_ratio
  type:
  - 'null'
  - double
  doc: 'Possible prior probabilities for the heterozygous indel call for the DRAGstr model parameter esimation.
    These are expressed in Phred scaled values with the following format: start:step:end. For example
    the default ''10:1.0:50'' indicate the sequence starting at 10 finishing at 50 sampled at 1.0 intervals.'
  inputBinding:
    position: 1
    prefix: --het-to-hom-ratio
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
- id: max_period
  type:
  - 'null'
  - int
  doc: maximum period considered in STR analysis
  inputBinding:
    position: 1
    prefix: --max-period
- id: max_repeats
  type:
  - 'null'
  - int
  doc: maximum repeat length (in repeated units) considered in STR analyses
  inputBinding:
    position: 1
    prefix: --max-repeats
- id: max_variants_per_shard
  type:
  - 'null'
  - int
  doc: If non-zero, partitions VCF output into shards, each containing up to the given number of records.
  inputBinding:
    position: 1
    prefix: --max-variants-per-shard
- id: min_loci_count
  type:
  - 'null'
  - int
  doc: Minimum number of sites for a repeat count and period length pair. The estimation will combine
    pairs that have a smaller number of such cases (same period but +/- 1 repeat count)
  inputBinding:
    position: 1
    prefix: --min-loci-count
- id: minimum_depth
  type:
  - 'null'
  - int
  doc: Minimum coverage to consider a locus for sampling
  inputBinding:
    position: 1
    prefix: --minimum-depth
- id: output_cram_version
  type:
  - 'null'
  - string
  doc: The CRAM version ('3.0' or '3.1') to write for CRAM output. Ignored for BAM/SAM output. Note that
    CRAM 3.1 (the default) cannot be read by tools that only support CRAM 3.0.
  inputBinding:
    position: 1
    prefix: --output-cram-version
- id: parallel
  type:
  - 'null'
  - boolean
  doc: run alignment data collection and estimation in parallel
  inputBinding:
    position: 1
    prefix: --parallel
- id: pileup_padding
  type:
  - 'null'
  - int
  doc: bases on either side of the repeat that are included in the STR pileup
  inputBinding:
    position: 1
    prefix: --pileup-padding
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
- id: sampling_min_mq
  type:
  - 'null'
  - int
  doc: the minimum read mapping quality allowed in sampled loci. Any read with a lower MQ will result
    in discarding that locus
  inputBinding:
    position: 1
    prefix: --sampling-min-mq
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
- id: shard_size
  type:
  - 'null'
  - int
  doc: when running in parallel this is the suggested shard size in base pairs. The actual shard-size
    may vary to adapt to small contigs and the requested number of threads
  inputBinding:
    position: 1
    prefix: --shard-size
- id: sites_only_vcf_output
  type:
  - 'null'
  - boolean
  doc: If true, don't emit genotype fields when writing vcf file output.
  inputBinding:
    position: 1
    prefix: --sites-only-vcf-output
- id: threads
  type:
  - 'null'
  - int
  doc: suggested number of parallel threads to perform the estimation, the default 0 leave it up to the
    VM to decide. When set to more than 1, this will activate parallel in the absence of --parallel
  inputBinding:
    position: 1
    prefix: --threads
- id: tmp_dir
  type:
  - 'null'
  - string
  doc: Temp directory to use.
  inputBinding:
    position: 1
    prefix: --tmp-dir
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
  doc: where to write the parameter output file.
  outputBinding:
    glob: $(inputs.output)
- id: debug_sites_output_file
  type:
  - 'null'
  - File
  doc: table with information gather on the samples sites. Includes what sites were downsampled, disqualified
    or accepted for parameter estimation
  outputBinding:
    glob: $(inputs.debug_sites_output)
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
