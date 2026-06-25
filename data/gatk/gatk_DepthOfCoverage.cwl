cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - DepthOfCoverage
label: gatk_DepthOfCoverage
doc: Generate coverage summary information for reads data
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: intervals
    type:
      type: array
      items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: output
    type: string
    doc: Base file location to which to write coverage summary information, must
      be a path to a file
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference
  - id: add_output_sam_program_record
    type:
      - 'null'
      - boolean
    doc: If true, adds a PG tag to created SAM/BAM/CRAM files.
    inputBinding:
      position: 101
      prefix: --add-output-sam-program-record
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
  - id: calculate_coverage_over_genes
    type:
      - 'null'
      - type: array
        items: string
    doc: Calculate coverage statistics over this list of genes
    inputBinding:
      position: 101
      prefix: --calculate-coverage-over-genes
  - id: cloud_index_prefetch_buffer
    type:
      - 'null'
      - int
    doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable).
    inputBinding:
      position: 101
      prefix: --cloud-index-prefetch-buffer
  - id: cloud_prefetch_buffer
    type:
      - 'null'
      - int
    doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable).
    inputBinding:
      position: 101
      prefix: --cloud-prefetch-buffer
  - id: count_type
    type:
      - 'null'
      - string
    doc: How should overlapping reads from the same fragment be handled?
    inputBinding:
      position: 101
      prefix: --count-type
  - id: create_output_bam_index
    type:
      - 'null'
      - boolean
    doc: If true, create a BAM/CRAM index when writing a coordinate-sorted 
      BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --create-output-bam-index
  - id: create_output_bam_md5
    type:
      - 'null'
      - boolean
    doc: If true, create a MD5 digest for any BAM/SAM/CRAM file created
    inputBinding:
      position: 101
      prefix: --create-output-bam-md5
  - id: create_output_variant_index
    type:
      - 'null'
      - boolean
    doc: If true, create a VCF index when writing a coordinate-sorted VCF file.
    inputBinding:
      position: 101
      prefix: --create-output-variant-index
  - id: create_output_variant_md5
    type:
      - 'null'
      - boolean
    doc: If true, create a a MD5 digest any VCF file created.
    inputBinding:
      position: 101
      prefix: --create-output-variant-md5
  - id: disable_bam_index_caching
    type:
      - 'null'
      - boolean
    doc: If true, don't cache bam indexes, this will reduce memory requirements 
      but may harm performance if many intervals are specified.
    inputBinding:
      position: 101
      prefix: --disable-bam-index-caching
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
      - File
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
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Lenient processing of VCF files
    inputBinding:
      position: 101
      prefix: --lenient
  - id: max_base_quality
    type:
      - 'null'
      - int
    doc: Maximum quality of bases to count towards depth
    inputBinding:
      position: 101
      prefix: --max-base-quality
  - id: max_depth_per_sample
    type:
      - 'null'
      - int
    doc: Maximum number of reads to retain per sample per locus.
    inputBinding:
      position: 101
      prefix: --max-depth-per-sample
  - id: max_variants_per_shard
    type:
      - 'null'
      - int
    doc: If non-zero, partitions VCF output into shards, each containing up to 
      the given number of records.
    inputBinding:
      position: 101
      prefix: --max-variants-per-shard
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum quality of bases to count towards depth
    inputBinding:
      position: 101
      prefix: --min-base-quality
  - id: omit_depth_output_at_each_base
    type:
      - 'null'
      - boolean
    doc: Do not output depth of coverage at each base
    inputBinding:
      position: 101
      prefix: --omit-depth-output-at-each-base
  - id: omit_genes_not_entirely_covered_by_traversal
    type:
      - 'null'
      - boolean
    doc: Do not output gene summary if it was not completely covered by 
      traversal intervals
    inputBinding:
      position: 101
      prefix: --omit-genes-not-entirely-covered-by-traversal
  - id: omit_interval_statistics
    type:
      - 'null'
      - boolean
    doc: Do not calculate per-interval statistics
    inputBinding:
      position: 101
      prefix: --omit-interval-statistics
  - id: omit_locus_table
    type:
      - 'null'
      - boolean
    doc: Do not calculate per-sample per-depth counts of loci
    inputBinding:
      position: 101
      prefix: --omit-locus-table
  - id: omit_per_sample_statistics
    type:
      - 'null'
      - boolean
    doc: Do not output the summary files per-sample
    inputBinding:
      position: 101
      prefix: --omit-per-sample-statistics
  - id: output_format
    type:
      - 'null'
      - string
    doc: The format of the output file
    inputBinding:
      position: 101
      prefix: --output-format
  - id: partition_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Partition type for depth of coverage
    inputBinding:
      position: 101
      prefix: --partition-type
  - id: print_base_counts
    type:
      - 'null'
      - boolean
    doc: Add base counts to per-locus output
    inputBinding:
      position: 101
      prefix: --print-base-counts
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
  - id: seconds_between_progress_updates
    type:
      - 'null'
      - float
    doc: Output traversal statistics every time this many seconds elapse
    inputBinding:
      position: 101
      prefix: --seconds-between-progress-updates
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: Use the given sequence dictionary as the master/canonical sequence 
      dictionary. Must be a .dict file.
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
  - id: sites_only_vcf_output
    type:
      - 'null'
      - boolean
    doc: If true, don't emit genotype fields when writing vcf file output.
    inputBinding:
      position: 101
      prefix: --sites-only-vcf-output
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
  - id: disable_tool_default_read_filters
    type:
      - 'null'
      - boolean
    doc: Disable all tool default read filters
    inputBinding:
      position: 101
      prefix: --disable-tool-default-read-filters
  - id: ignore_deletion_sites
    type:
      - 'null'
      - boolean
    doc: Ignore sites consisting only of deletions
    inputBinding:
      position: 101
      prefix: --ignore-deletion-sites
  - id: include_deletions
    type:
      - 'null'
      - boolean
    doc: Include information on deletions alongside other bases in output table 
      counts
    inputBinding:
      position: 101
      prefix: --include-deletions
  - id: include_ref_n_sites
    type:
      - 'null'
      - boolean
    doc: Include sites where the reference is N
    inputBinding:
      position: 101
      prefix: --include-ref-n-sites
  - id: n_bins
    type:
      - 'null'
      - int
    doc: Number of bins to use for granular binning
    inputBinding:
      position: 101
      prefix: --nBins
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: start
    type:
      - 'null'
      - int
    doc: Starting (left endpoint) for granular binning
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Ending (right endpoint) for granular binning
    inputBinding:
      position: 101
      prefix: --stop
  - id: summary_coverage_threshold
    type:
      - 'null'
      - type: array
        items: int
    doc: Coverage threshold (in percent) for summarizing statistics
    inputBinding:
      position: 101
      prefix: --summary-coverage-threshold
outputs:
  - id: output_output
    type: File[]
    doc: Base file location to which to write coverage summary information, must
      be a path to a file
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
