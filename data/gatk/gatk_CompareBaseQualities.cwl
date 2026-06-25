cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CompareBaseQualities
label: gatk_CompareBaseQualities
doc: Compares the base qualities of two SAM/BAM/CRAM files. The reads in the two
  files must have exactly the same names and appear in the same order.
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input SAM/BAM/CRAM files to compare. At least 2 positional arguments 
      must be specified.
    inputBinding:
      position: 1
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 102
      prefix: --arguments_file
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and GELI).
    inputBinding:
      position: 102
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create a BAM index when writing a coordinate-sorted BAM 
      file.
    inputBinding:
      position: 102
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    inputBinding:
      position: 102
      prefix: --CREATE_MD5_FILE
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 102
      prefix: --gatk-config-file
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 102
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets. If unset, 
      these buckets cannot be accessed.
    inputBinding:
      position: 102
      prefix: --gcs-project-for-requester-pays
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing SAM files that need to be sorted, this will specify the 
      number of records stored in RAM before spilling to disk.
    inputBinding:
      position: 102
      prefix: --MAX_RECORDS_IN_RAM
  - id: output
    type: string
    doc: Summary output file.
    inputBinding:
      position: 102
      prefix: --output
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 102
      prefix: --QUIET
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference sequence file.
    inputBinding:
      position: 102
      prefix: --reference
  - id: throw_on_diff
    type:
      - 'null'
      - boolean
    doc: Throw exception on difference.
    inputBinding:
      position: 102
      prefix: --throw-on-diff
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 102
      prefix: --tmp-dir
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 102
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 102
      prefix: --use-jdk-inflater
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 102
      prefix: --VALIDATION_STRINGENCY
  - id: round_down_quantized
    type:
      - 'null'
      - boolean
    doc: Round down quality scores to nearest quantized value.
    inputBinding:
      position: 102
      prefix: --round-down-quantized
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 102
      prefix: --showHidden
  - id: static_quantized_quals
    type:
      - 'null'
      - type: array
        items: int
    doc: Use static quantized quality scores to a given number of levels (with 
      --bqsr-recal-file)
    inputBinding:
      position: 102
      prefix: --static-quantized-quals
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Summary output file.
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
