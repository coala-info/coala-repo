cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CreateReadCountPanelOfNormals
label: gatk_CreateReadCountPanelOfNormals
doc: Creates a panel of normals for read-count denoising given the read counts 
  for samples in the panel
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input TSV or HDF5 files containing integer read counts in genomic 
      intervals for all samples in the panel of normals (output of 
      CollectReadCounts). Intervals must be identical and in the same order for 
      all samples. This argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output file for the panel of normals.
    inputBinding:
      position: 101
      prefix: --output
  - id: annotated_intervals
    type:
      - 'null'
      - File
    doc: Input file containing annotations for GC content in genomic intervals 
      (output of AnnotateIntervals). If provided, explicit GC correction will be
      performed before performing SVD.
    inputBinding:
      position: 101
      prefix: --annotated-intervals
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
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
  - id: do_impute_zeros
    type:
      - 'null'
      - boolean
    doc: If true, impute zero-coverage values as the median of the non-zero 
      values in the corresponding interval.
    inputBinding:
      position: 101
      prefix: --do-impute-zeros
  - id: extreme_outlier_truncation_percentile
    type:
      - 'null'
      - float
    doc: Fractional coverages normalized by genomic-interval medians that are 
      strictly below this percentile or strictly above the complementary 
      percentile are set to the corresponding percentile value.
    inputBinding:
      position: 101
      prefix: --extreme-outlier-truncation-percentile
  - id: extreme_sample_median_percentile
    type:
      - 'null'
      - float
    doc: Samples with a median (across genomic intervals) of fractional coverage
      normalized by genomic-interval medians strictly below this percentile or 
      strictly above the complementary percentile are filtered out.
    inputBinding:
      position: 101
      prefix: --extreme-sample-median-percentile
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
    doc: Project to bill when accessing "requester pays" buckets. If unset, 
      these buckets cannot be accessed.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: maximum_zeros_in_interval_percentage
    type:
      - 'null'
      - float
    doc: Genomic intervals with a fraction of zero-coverage samples greater than
      or equal to this percentage are filtered out.
    inputBinding:
      position: 101
      prefix: --maximum-zeros-in-interval-percentage
  - id: maximum_zeros_in_sample_percentage
    type:
      - 'null'
      - float
    doc: Samples with a fraction of zero-coverage genomic intervals greater than
      or equal to this percentage are filtered out.
    inputBinding:
      position: 101
      prefix: --maximum-zeros-in-sample-percentage
  - id: minimum_interval_median_percentile
    type:
      - 'null'
      - float
    doc: Genomic intervals with a median (across samples) of fractional coverage
      (optionally corrected for GC bias) less than or equal to this percentile 
      are filtered out.
    inputBinding:
      position: 101
      prefix: --minimum-interval-median-percentile
  - id: number_of_eigensamples
    type:
      - 'null'
      - int
    doc: Number of eigensamples to use for truncated SVD and to store in the 
      panel of normals.
    inputBinding:
      position: 101
      prefix: --number-of-eigensamples
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
  - id: maximum_chunk_size
    type:
      - 'null'
      - int
    doc: Maximum HDF5 matrix chunk size.
    inputBinding:
      position: 101
      prefix: --maximum-chunk-size
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
    doc: Output file for the panel of normals.
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
