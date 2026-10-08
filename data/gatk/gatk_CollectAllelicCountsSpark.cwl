cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CollectAllelicCountsSpark
label: gatk_CollectAllelicCountsSpark
doc: Collects reference and alternate allele counts at specified sites
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '^.bai'
        required: false
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
  - id: intervals_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --intervals
    doc: One or more interval files (interval_list, BED or VCF) over which to 
      operate. Use this instead of intervals when the intervals are in a file.
    inputBinding:
      position: 101
  - id: output
    type: string
    doc: Output file for allelic counts.
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type:
      - File
    secondaryFiles:
      - .fai
      - ^.dict
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference
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
        inputBinding:
          prefix: --arguments_file
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
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
        inputBinding:
          prefix: --conf
    doc: Spark properties to set on the Spark context in the format 
      <property>=<value>
    inputBinding:
      position: 101
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
        inputBinding:
          prefix: --disable-read-filter
    doc: Read filters to be disabled before analysis
    inputBinding:
      position: 101
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
        inputBinding:
          prefix: --exclude-intervals
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
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
  - id: inverted_read_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --inverted-read-filter
    doc: Inverted (with flipped acceptance/failure conditions) read filters 
      applied before analysis
    inputBinding:
      position: 101
  - id: max_depth_per_sample
    type:
      - 'null'
      - int
    doc: Maximum number of reads to retain per sample per locus.
    inputBinding:
      position: 101
      prefix: --max-depth-per-sample
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality. Base calls with lower quality will be filtered 
      out of pileups.
    inputBinding:
      position: 101
      prefix: --minimum-base-quality
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
      - string
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
        inputBinding:
          prefix: --read-filter
    doc: Read filters to be applied before analysis
    inputBinding:
      position: 101
  - id: read_index
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --read-index
    doc: Indices to use for the read inputs.
    inputBinding:
      position: 101
  - id: read_shard_size
    type:
      - 'null'
      - int
    doc: Maximum size of each read shard, in bases.
    inputBinding:
      position: 101
      prefix: --read-shard-size
  - id: read_validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM/BAM/CRAM/SRA files read by this 
      program.
    inputBinding:
      position: 101
      prefix: --read-validation-stringency
  - id: sharded_output
    type:
      - 'null'
      - boolean
    doc: For tools that write an output, write the output in multiple pieces 
      (shards)
    inputBinding:
      position: 101
      prefix: --sharded-output
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: whether to use the shuffle implementation or overlaps partitioning
    inputBinding:
      position: 101
      prefix: --shuffle
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
      - string
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
outputs:
  - id: output_output
    type: File
    doc: Output file for allelic counts.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
