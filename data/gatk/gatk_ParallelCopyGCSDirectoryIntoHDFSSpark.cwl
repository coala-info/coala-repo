cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ParallelCopyGCSDirectoryIntoHDFSSpark
label: gatk_ParallelCopyGCSDirectoryIntoHDFSSpark
doc: |-
  This tool uses a Spark cluster to do a parallel copy of either a single file or a directory from Google Cloud Storage (GCS) into the HDFS file system used by Spark to support Resilient Distributed Datasets (RDDs). Files are divided into chunks of size equal to the HDFS block size (with the exception of the final chunk) and each Spark task is responsible for copying one chunk. To copy all of the files in a GCS directory, provide the GCS directory path, including the trailing slash. Directory copies are non-recursive so subdirectories will be skipped. Within directories each file is divided into chunks independently (so this will be inefficient if you have lots of files smaller than the block size). After all chunks are copied, the HDFS concat method is used to stitch together chunks into single files without re-copying them. This functionality is used by the structural variation workflow to copy reference data when a Spark cluster is created, and may also be used to copy sample data to a Spark cluster.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input_gcs_path
  type: string
  doc: input GCS file path (add trailing slash when specifying a directory)
  inputBinding:
    prefix: --input-gcs-path
- id: output_hdfs_directory
  type: string
  doc: output directory on HDFS to into which to transfer the data (will be created
    by the tool)
  inputBinding:
    prefix: --output-hdfs-directory
- id: bam_partition_size
  type:
  - 'null'
  - long
  doc: 'maximum number of bytes to read from a file into each partition of reads.
    Setting this higher will result in fewer partitions. Note that this will not be
    equal to the size of the partition in memory. Defaults to 0, which uses the default
    split size (determined by the Hadoop input format, typically the size of one HDFS
    block). Default value: 0.'
  inputBinding:
    prefix: --bam-partition-size
- id: conf
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --conf
  doc: Spark properties to set on the Spark context in the format <property>=<value>
    This argument may be specified 0 or more times.
- id: create_output_bam_splitting_index
  type:
  - 'null'
  - boolean
  doc: 'If true, create a BAM splitting index (SBI) when writing a coordinate-sorted
    BAM file. Default value: true. Possible values: {true, false}'
  inputBinding:
    prefix: --create-output-bam-splitting-index
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing This argument may
    be specified 0 or more times.
- id: input_file_glob
  type:
  - 'null'
  - string
  doc: 'optional wildcard glob to subset files in the input directory to copy Default
    value: *.'
  inputBinding:
    prefix: --input-file-glob
- id: interval_padding
  type:
  - 'null'
  - int
  doc: 'Amount of padding (in bp) to add to each interval you are including. Default
    value: 0.'
  inputBinding:
    prefix: --interval-padding
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate This argument may be specified
    0 or more times.
- id: num_reducers
  type:
  - 'null'
  - int
  doc: 'For tools that shuffle data or write an output, sets the number of reducers.
    Defaults to 0, which gives one partition per 10MB of input. Default value: 0.'
  inputBinding:
    prefix: --num-reducers
- id: output_shard_tmp_dir
  type:
  - 'null'
  - string
  doc: when writing a bam, in single sharded mode this directory to write the temporary
    intermediate output shards, if not specified .parts/ will be used Cannot be used
    in conjunction with argument(s) shardedOutput
  inputBinding:
    prefix: --output-shard-tmp-dir
- id: program_name
  type:
  - 'null'
  - string
  doc: Name of the program running
  inputBinding:
    prefix: --program-name
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
- id: sharded_output
  type:
  - 'null'
  - boolean
  doc: 'For tools that write an output, write the output in multiple pieces (shards)
    Default value: false. Possible values: {true, false} Cannot be used in conjunction
    with argument(s) shardedPartsDir'
  inputBinding:
    prefix: --sharded-output
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: spark_master
  type:
  - 'null'
  - string
  doc: 'URL of the Spark Master to submit jobs to when using the Spark pipeline runner.
    Default value: local[*].'
  inputBinding:
    prefix: --spark-master
- id: spark_verbosity
  type:
  - 'null'
  - string
  doc: 'Spark verbosity. Overrides --verbosity for Spark-generated logs only. Possible
    values: {ALL, DEBUG, INFO, WARN, ERROR, FATAL, OFF, TRACE}'
  inputBinding:
    prefix: --spark-verbosity
- id: splitting_index_granularity
  type:
  - 'null'
  - long
  doc: 'Granularity to use when writing a splitting index, one entry will be put into
    the index every n reads where n is this granularity value. Smaller granularity
    results in a larger index with more available split points. Default value: 4096.'
  inputBinding:
    prefix: --splitting-index-granularity
- id: use_nio
  type:
  - 'null'
  - boolean
  doc: 'Whether to use NIO or the Hadoop filesystem (default) for reading files. (Note
    that the Hadoop filesystem is always used for writing files.) Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --use-nio
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs: []
requirements:
- class: InlineJavascriptRequirement
- class: EnvVarRequirement
  envDef:
  - envName: SPARK_LOCAL_IP
    envValue: 127.0.0.1
  - envName: SPARK_LOCAL_HOSTNAME
    envValue: localhost
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
