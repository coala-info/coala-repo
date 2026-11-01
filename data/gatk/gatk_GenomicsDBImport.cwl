cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GenomicsDBImport
label: gatk_GenomicsDBImport
doc: 'Import VCFs to GenomicsDB


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: genomicsdb_update_workspace_path
  type:
  - 'null'
  - Directory
  doc: Workspace when updating GenomicsDB. Can be a POSIX file system absolute or relative path or a HDFS/GCS
    URL. Use this argument when adding new samples to an existing GenomicsDB workspace or when using the
    output-interval-list-to-file option. Either this or genomicsdb-workspace-path must be specified. Must
    point to an existing workspace.
  inputBinding:
    position: 1
    valueFrom: $(self.basename)
    prefix: --genomicsdb-update-workspace-path
- id: genomicsdb_workspace_path
  type:
  - 'null'
  - string
  doc: Workspace for GenomicsDB. Can be a POSIX file system absolute or relative path or a HDFS/GCS URL.
    Use this argument when creating a new GenomicsDB workspace. Either this or genomicsdb-update-workspace-path
    must be specified. Must be an empty or non-existent directory.
  inputBinding:
    position: 1
    prefix: --genomicsdb-workspace-path
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
- id: batch_size
  type:
  - 'null'
  - int
  doc: Batch size controls the number of samples for which readers are open at once and therefore provides
    a way to minimize memory consumption. However, it can take longer to complete. Use the consolidate
    flag if more than a hundred batches were used. This will improve feature read time. batchSize=0 means
    no batching (i.e. readers for all samples will be opened at once) Defaults to 0
  inputBinding:
    position: 1
    prefix: --batch-size
- id: bypass_feature_reader
  type:
  - 'null'
  - boolean
  doc: Use htslib to read input VCFs instead of GATK's FeatureReader. This will reduce memory usage and
    potentially speed up the import. Lower memory requirements may also enable parallelism through max-num-intervals-to-import-in-parallel.
    To enable this option, VCFs must be normalized, block-compressed and indexed.
  inputBinding:
    position: 1
    prefix: --bypass-feature-reader
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
- id: consolidate
  type:
  - 'null'
  - boolean
  doc: Boolean flag to enable consolidation. If importing data in batches, a new fragment is created for
    each batch. In case thousands of fragments are created, GenomicsDB feature readers will try to open
    ~20x as many files. Also, internally GenomicsDB would consume more memory to maintain bookkeeping
    data from all fragments. Use this flag to merge all fragments into one. Merging can potentially improve
    read performance, however overall benefit might not be noticeable as the top Java layers have significantly
    higher overheads. This flag has no effect if only one batch is used. Defaults to false
  inputBinding:
    position: 1
    prefix: --consolidate
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
- id: genomicsdb_segment_size
  type:
  - 'null'
  - long
  doc: Buffer size in bytes allocated for GenomicsDB attributes during import. Should be large enough
    to hold data from one site.
  inputBinding:
    position: 1
    prefix: --genomicsdb-segment-size
- id: genomicsdb_shared_posixfs_optimizations
  type:
  - 'null'
  - boolean
  doc: Allow for optimizations to improve the usability and performance for shared Posix Filesystems(e.g.
    NFS, Lustre). If set, file level locking is disabled and file system writes are minimized by keeping
    a higher number of file descriptors open for longer periods of time. Use with batch-size option if
    keeping a large number of file descriptors open is an issue
  inputBinding:
    position: 1
    prefix: --genomicsdb-shared-posixfs-optimizations
- id: genomicsdb_use_gcs_hdfs_connector
  type:
  - 'null'
  - boolean
  doc: Use the GCS HDFS Connector instead of the native GCS SDK client with gs:// URLs.
  inputBinding:
    position: 1
    prefix: --genomicsdb-use-gcs-hdfs-connector
- id: genomicsdb_vcf_buffer_size
  type:
  - 'null'
  - long
  doc: Buffer size in bytes to store variant contexts. Larger values are better as smaller values cause
    frequent disk writes. Defaults to 16384 which was empirically determined to work well for many inputs.
  inputBinding:
    position: 1
    prefix: --genomicsdb-vcf-buffer-size
- id: header
  type:
  - 'null'
  - File
  doc: Specify a vcf file to use instead of reading and combining headers from the input vcfs
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --header
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
- id: max_variants_per_shard
  type:
  - 'null'
  - int
  doc: If non-zero, partitions VCF output into shards, each containing up to the given number of records.
  inputBinding:
    position: 1
    prefix: --max-variants-per-shard
- id: merge_input_intervals
  type:
  - 'null'
  - boolean
  doc: Boolean flag to import all data in between intervals. Improves performance using large lists of
    intervals, as in exome sequencing, especially if GVCF data only exists for specified intervals.
  inputBinding:
    position: 1
    prefix: --merge-input-intervals
- id: output_cram_version
  type:
  - 'null'
  - string
  doc: The CRAM version ('3.0' or '3.1') to write for CRAM output. Ignored for BAM/SAM output. Note that
    CRAM 3.1 (the default) cannot be read by tools that only support CRAM 3.0.
  inputBinding:
    position: 1
    prefix: --output-cram-version
- id: output_interval_list_to_file
  type:
  - 'null'
  - string
  doc: Path to output file where intervals from existing workspace should be written.If this option is
    specified, the tools outputs the interval_list of the workspace pointed to by genomicsdb-update-workspace-path
    at the path specified here in a Picard-style interval_list with a sequence dictionary header
  inputBinding:
    position: 1
    prefix: --output-interval-list-to-file
- id: overwrite_existing_genomicsdb_workspace
  type:
  - 'null'
  - boolean
  doc: Will overwrite given workspace if it exists. Otherwise a new workspace is created. Cannot be set
    to true if genomicsdb-update-workspace-path is also set. Defaults to false
  inputBinding:
    position: 1
    prefix: --overwrite-existing-genomicsdb-workspace
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
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
  inputBinding:
    position: 1
    prefix: --reference
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
- id: validate_sample_name_map
  type:
  - 'null'
  - boolean
  doc: Boolean flag to enable checks on the sampleNameMap file. If true, tool checks whetherfeature readers
    are valid and shows a warning if sample names do not match with the headers. Defaults to false
  inputBinding:
    position: 1
    prefix: --validate-sample-name-map
- id: variant
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --variant
  doc: GVCF files to be imported to GenomicsDB. Each file must contain data for only a single sample.
    Either this or sample-name-map must be specified.
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
- id: verbosity
  type:
  - 'null'
  - string
  doc: Control verbosity of logging.
  inputBinding:
    position: 1
    prefix: --verbosity
- id: avoid_nio
  type:
  - 'null'
  - boolean
  doc: Do not attempt to open the input vcf file paths in java. This can only be used with bypass-feature-reader.
    It allows operating on file systems which GenomicsDB understands how to open but GATK does not. This
    will disable many of the sanity checks.
  inputBinding:
    position: 1
    prefix: --avoid-nio
- id: disable_tool_default_read_filters
  type:
  - 'null'
  - boolean
  doc: 'Disable all tool default read filters (WARNING: many tools will not function correctly without
    their default read filters on)'
  inputBinding:
    position: 1
    prefix: --disable-tool-default-read-filters
- id: max_num_intervals_to_import_in_parallel
  type:
  - 'null'
  - int
  doc: Max number of intervals to import in parallel; higher values may improve performance, but require
    more memory and a higher number of file descriptors open at the same time
  inputBinding:
    position: 1
    prefix: --max-num-intervals-to-import-in-parallel
- id: merge_contigs_into_num_partitions
  type:
  - 'null'
  - int
  doc: Number of GenomicsDB arrays to merge input intervals into. Defaults to 0, which disables this merging.
    This option can only be used if entire contigs are specified as intervals. The tool will not split
    up a contig into multiple arrays, which means the actual number of partitions may be less than what
    is specified for this argument. This can improve performance in the case where the user is trying
    to import a very large number of contigs - larger than 100
  inputBinding:
    position: 1
    prefix: --merge-contigs-into-num-partitions
- id: reader_threads
  type:
  - 'null'
  - int
  doc: How many simultaneous threads to use when opening VCFs in batches; higher values may improve performance
    when network latency is an issue. Multiple reader threads are not supported when running with multiple
    intervals.
  inputBinding:
    position: 1
    prefix: --reader-threads
- id: sample_name_map
  type:
  - 'null'
  - File
  doc: Path to file containing a mapping of sample name to file uri in tab delimited format. If this is
    specified then the header from the first sample will be treated as the merged header rather than merging
    the headers, and the sample names will be taken from this file. This may be used to rename input samples.
    This is a performance optimization that relaxes the normal checks for consistent headers. Using vcfs
    with incompatible headers may result in silent data corruption.
  inputBinding:
    position: 1
    prefix: --sample-name-map
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
- id: sample_name_map_files
  type:
  - 'null'
  - type: array
    items: File
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  doc: Files named in the sample name map. They are staged next to the map so the relative names in the
    map resolve.
outputs:
- id: genomicsdb_workspace_path_file
  type:
  - 'null'
  - Directory
  doc: Workspace for GenomicsDB. Can be a POSIX file system absolute or relative path or a HDFS/GCS URL.
    Use this argument when creating a new GenomicsDB workspace. Either this or genomicsdb-update-workspace-path
    must be specified. Must be an empty or non-existent directory.
  outputBinding:
    glob: $(inputs.genomicsdb_workspace_path)
- id: output_interval_list_to_file_file
  type:
  - 'null'
  - File
  doc: Path to output file where intervals from existing workspace should be written.If this option is
    specified, the tools outputs the interval_list of the workspace pointed to by genomicsdb-update-workspace-path
    at the path specified here in a Picard-style interval_list with a sequence dictionary header
  outputBinding:
    glob: $(inputs.output_interval_list_to_file)
- id: updated_genomicsdb_workspace
  type:
  - 'null'
  - Directory
  doc: The GenomicsDB workspace after an update (when --genomicsdb-update-workspace-path is used).
  outputBinding:
    glob: '$(inputs.genomicsdb_update_workspace_path ? inputs.genomicsdb_update_workspace_path.basename
      : null)'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.genomicsdb_update_workspace_path)
    writable: true
  - $(inputs.sample_name_map_files)
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
