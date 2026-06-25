cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CollectQualityYieldMetricsSpark
label: gatk_CollectQualityYieldMetricsSpark
doc: Collects quality yield metrics from SAM/BAM/CRAM file(s). The tool 
  leverages the Spark framework for faster operation.
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: File to write the output to.
    inputBinding:
      position: 101
      prefix: --output
  - id: add_output_vcf_command_line
    type:
      - 'null'
      - boolean
    doc: If true, adds a command line header line to created VCF files.
    inputBinding:
      position: 101
      prefix: --add-output-vcf-command-line
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: bam_partition_size
    type:
      - 'null'
      - int
    doc: maximum number of bytes to read from a file into each partition of 
      reads.
    inputBinding:
      position: 101
      prefix: --bam-partition-size
  - id: conf
    type:
      - 'null'
      - type: array
        items: string
    doc: Spark properties to set on the Spark context in the format 
      <property>=<value>
    inputBinding:
      position: 101
      prefix: --conf
  - id: create_output_bam_index
    type:
      - 'null'
      - boolean
    doc: If true, create a BAM index when writing a coordinate-sorted BAM file.
    inputBinding:
      position: 101
      prefix: --create-output-bam-index
  - id: create_output_bam_splitting_index
    type:
      - 'null'
      - boolean
    doc: If true, create a BAM splitting index (SBI) when writing a 
      coordinate-sorted BAM file.
    inputBinding:
      position: 101
      prefix: --create-output-bam-splitting-index
  - id: create_output_variant_index
    type:
      - 'null'
      - boolean
    doc: If true, create a VCF index when writing a coordinate-sorted VCF file.
    inputBinding:
      position: 101
      prefix: --create-output-variant-index
  - id: disable_read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Read filters to be disabled before analysis
    inputBinding:
      position: 101
      prefix: --disable-read-filter
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    doc: If specified, do not check the sequence dictionaries from our inputs 
      for compatibility.
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --exclude-intervals
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 101
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: interval_exclusion_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are excluding.
    inputBinding:
      position: 101
      prefix: --interval-exclusion-padding
  - id: interval_merging_rule
    type:
      - 'null'
      - string
    doc: Interval merging rule for abutting intervals
    inputBinding:
      position: 101
      prefix: --interval-merging-rule
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are including.
    inputBinding:
      position: 101
      prefix: --interval-padding
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: Set merging approach to use for combining interval inputs
    inputBinding:
      position: 101
      prefix: --interval-set-rule
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: inverted_read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Inverted (with flipped acceptance/failure conditions) read filters 
      applied before analysis
    inputBinding:
      position: 101
      prefix: --inverted-read-filter
  - id: num_reducers
    type:
      - 'null'
      - int
    doc: For tools that shuffle data or write an output, sets the number of 
      reducers.
    inputBinding:
      position: 101
      prefix: --num-reducers
  - id: output_shard_tmp_dir
    type:
      - 'null'
      - Directory
    doc: when writing a bam, in single sharded mode this directory to write the 
      temporary intermediate output shards
    inputBinding:
      position: 101
      prefix: --output-shard-tmp-dir
  - id: program_name
    type:
      - 'null'
      - string
    doc: Name of the program running
    inputBinding:
      position: 101
      prefix: --program-name
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Read filters to be applied before analysis
    inputBinding:
      position: 101
      prefix: --read-filter
  - id: read_index
    type:
      - 'null'
      - type: array
        items: File
    doc: Indices to use for the read inputs.
    inputBinding:
      position: 101
      prefix: --read-index
  - id: read_validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM/BAM/CRAM/SRA files read by this 
      program.
    inputBinding:
      position: 101
      prefix: --read-validation-stringency
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference sequence
    inputBinding:
      position: 101
      prefix: --reference
  - id: sharded_output
    type:
      - 'null'
      - boolean
    doc: For tools that write an output, write the output in multiple pieces 
      (shards)
    inputBinding:
      position: 101
      prefix: --sharded-output
  - id: spark_master
    type:
      - 'null'
      - string
    doc: URL of the Spark Master to submit jobs to when using the Spark pipeline
      runner.
    inputBinding:
      position: 101
      prefix: --spark-master
  - id: spark_verbosity
    type:
      - 'null'
      - string
    doc: Spark verbosity. Overrides --verbosity for Spark-generated logs only.
    inputBinding:
      position: 101
      prefix: --spark-verbosity
  - id: splitting_index_granularity
    type:
      - 'null'
      - int
    doc: Granularity to use when writing a splitting index
    inputBinding:
      position: 101
      prefix: --splitting-index-granularity
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-inflater
  - id: use_nio
    type:
      - 'null'
      - boolean
    doc: Whether to use NIO or the Hadoop filesystem (default) for reading 
      files.
    inputBinding:
      position: 101
      prefix: --use-nio
  - id: use_original_qualities
    type:
      - 'null'
      - boolean
    doc: If available in the OQ tag, use the original quality scores as inputs 
      instead of the quality scores in the QUAL field.
    inputBinding:
      position: 101
      prefix: --use-original-qualities
  - id: disable_tool_default_read_filters
    type:
      - 'null'
      - boolean
    doc: Disable all tool default read filters
    inputBinding:
      position: 101
      prefix: --disable-tool-default-read-filters
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: ambig_filter_bases
    type:
      - 'null'
      - int
    doc: Threshold number of ambiguous bases.
    inputBinding:
      position: 101
      prefix: --ambig-filter-bases
  - id: ambig_filter_frac
    type:
      - 'null'
      - float
    doc: Threshold fraction of ambiguous bases
    inputBinding:
      position: 101
      prefix: --ambig-filter-frac
  - id: max_clipped_bases
    type:
      - 'null'
      - int
    doc: Maximum number of clipped bases on either end of a given read
    inputBinding:
      position: 101
      prefix: --max-clipped-bases
  - id: read_filter_max_hmer
    type:
      - 'null'
      - int
    doc: maxHmer to use for testing in the filter
    inputBinding:
      position: 101
      prefix: --read-filter-max-hmer
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: Maximum length of fragment (insert size)
    inputBinding:
      position: 101
      prefix: --max-fragment-length
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: Minimum length of fragment (insert size)
    inputBinding:
      position: 101
      prefix: --min-fragment-length
  - id: keep_intervals
    type:
      type: array
      items: string
    doc: One or more genomic intervals to keep
    inputBinding:
      position: 101
      prefix: --keep-intervals
  - id: read_filter_expression
    type:
      type: array
      items: string
    doc: One or more JEXL expressions used to filter
    inputBinding:
      position: 101
      prefix: --read-filter-expression
  - id: library
    type:
      type: array
      items: string
    doc: Name of the library to keep
    inputBinding:
      position: 101
      prefix: --library
  - id: maximum_mapping_quality
    type:
      - 'null'
      - int
    doc: Maximum mapping quality to keep (inclusive)
    inputBinding:
      position: 101
      prefix: --maximum-mapping-quality
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to keep (inclusive)
    inputBinding:
      position: 101
      prefix: --minimum-mapping-quality
  - id: mate_too_distant_length
    type:
      - 'null'
      - int
    doc: Minimum start location difference at which mapped mates are considered 
      distant
    inputBinding:
      position: 101
      prefix: --mate-too-distant-length
  - id: dont_require_soft_clips_both_ends
    type:
      - 'null'
      - boolean
    doc: Allow a read to be filtered out based on having only 1 soft-clipped 
      block.
    inputBinding:
      position: 101
      prefix: --dont-require-soft-clips-both-ends
  - id: filter_too_short
    type:
      - 'null'
      - int
    doc: Minimum number of aligned bases
    inputBinding:
      position: 101
      prefix: --filter-too-short
  - id: platform_filter_name
    type:
      type: array
      items: string
    doc: Platform attribute (PL) to match
    inputBinding:
      position: 101
      prefix: --platform-filter-name
  - id: black_listed_lanes
    type:
      type: array
      items: string
    doc: Platform unit (PU) to filter out
    inputBinding:
      position: 101
      prefix: --black-listed-lanes
  - id: read_group_black_list
    type:
      type: array
      items: string
    doc: A read group filter expression in the form "attribute:value"
    inputBinding:
      position: 101
      prefix: --read-group-black-list
  - id: keep_read_group
    type: string
    doc: The name of the read group to keep
    inputBinding:
      position: 101
      prefix: --keep-read-group
  - id: max_read_length
    type: int
    doc: Keep only reads with length at most equal to the specified value
    inputBinding:
      position: 101
      prefix: --max-read-length
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Keep only reads with length at least equal to the specified value
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: read_name
    type:
      type: array
      items: string
    doc: Keep only reads with this read name
    inputBinding:
      position: 101
      prefix: --read-name
  - id: keep_reverse_strand_only
    type: boolean
    doc: Keep only reads on the reverse strand
    inputBinding:
      position: 101
      prefix: --keep-reverse-strand-only
  - id: read_filter_tag
    type: string
    doc: Look for this tag in read
    inputBinding:
      position: 101
      prefix: --read-filter-tag
  - id: read_filter_tag_comp
    type:
      - 'null'
      - float
    doc: Compare value in tag to this value
    inputBinding:
      position: 101
      prefix: --read-filter-tag-comp
  - id: read_filter_tag_op
    type:
      - 'null'
      - string
    doc: Compare value in tag to value with this operator.
    inputBinding:
      position: 101
      prefix: --read-filter-tag-op
  - id: sample
    type:
      type: array
      items: string
    doc: The name of the sample(s) to keep, filtering out all others
    inputBinding:
      position: 101
      prefix: --sample
  - id: max_soft_clipped_leading_trailing_ratio
    type:
      - 'null'
      - float
    doc: Threshold ratio of soft clipped bases (leading / trailing the cigar 
      string) to total bases in read for read to be filtered.
    inputBinding:
      position: 101
      prefix: --max-soft-clipped-leading-trailing-ratio
  - id: max_soft_clipped_ratio
    type:
      - 'null'
      - float
    doc: Threshold ratio of soft clipped bases (anywhere in the cigar string) to
      total bases in read for read to be filtered.
    inputBinding:
      position: 101
      prefix: --max-soft-clipped-ratio
outputs:
  - id: output_output
    type: File
    doc: File to write the output to.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
