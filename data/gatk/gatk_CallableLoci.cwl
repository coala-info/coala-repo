cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CallableLoci
label: gatk_CallableLoci
doc: Collect statistics on callable, uncallable, poorly mapped, and other parts 
  of the genome
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
    doc: Output file (BED or per-base format)
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
  - id: summary
    type: string
    doc: Name of file for output summary
    inputBinding:
      position: 101
      prefix: --summary
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
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Lenient processing of VCF files
    inputBinding:
      position: 101
      prefix: --lenient
  - id: max_depth_upper_bound
    type:
      - 'null'
      - int
    doc: Maximum read depth before a locus is considered poorly mapped
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: max_depth_per_sample
    type:
      - 'null'
      - int
    doc: Maximum number of reads to retain per sample per locus.
    inputBinding:
      position: 101
      prefix: --max-depth-per-sample
  - id: max_fraction_of_reads_with_low_mapq
    type:
      - 'null'
      - float
    doc: If the fraction of reads at a base with low mapping quality exceeds 
      this value, the site may be poorly mapped
    inputBinding:
      position: 101
      prefix: --max-fraction-of-reads-with-low-mapq
  - id: max_low_mapq
    type:
      - 'null'
      - int
    doc: Maximum value for MAPQ to be considered a problematic mapped read
    inputBinding:
      position: 101
      prefix: --max-low-mapq
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
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality of reads to count towards depth
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
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
  - id: format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 101
      prefix: --format
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum QC+ read depth before a locus is considered callable
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_depth_for_low_mapq
    type:
      - 'null'
      - int
    doc: Minimum read depth before a locus is considered a potential candidate 
      for poorly mapped
    inputBinding:
      position: 101
      prefix: --min-depth-for-low-mapq
outputs:
  - id: output_output
    type: File
    doc: Output file (BED or per-base format)
    outputBinding:
      glob: $(inputs.output)
  - id: output_summary
    type: File
    doc: Name of file for output summary
    outputBinding:
      glob: $(inputs.summary)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
