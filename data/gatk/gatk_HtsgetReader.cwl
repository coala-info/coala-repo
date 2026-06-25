cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - HtsgetReader
label: gatk_HtsgetReader
doc: Download a file using htsget
inputs:
  - id: id
    type: string
    doc: ID of record to request.
    inputBinding:
      position: 101
      prefix: --id
  - id: output
    type: string
    doc: Output file.
    inputBinding:
      position: 101
      prefix: --output
  - id: url
    type: string
    doc: URL of htsget endpoint.
    inputBinding:
      position: 101
      prefix: --url
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: check_md5
    type:
      - 'null'
      - boolean
    doc: Boolean determining whether to calculate the md5 digest of the 
      assembled file and validate it against the provided md5 hash, if it 
      exists.
    inputBinding:
      position: 101
      prefix: --check-md5
  - id: class
    type:
      - 'null'
      - string
    doc: 'Class of data to request. Possible values: {body, header}'
    inputBinding:
      position: 101
      prefix: --class
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A field to include, default: all. Possible values: {QNAME, FLAG, RNAME,
      POS, MAPQ, CIGAR, RNEXT, PNEXT, TLEN, SEQ, QUAL}'
    inputBinding:
      position: 101
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format to request record data in. Possible values: {BAM, CRAM, VCF, BCF}'
    inputBinding:
      position: 101
      prefix: --format
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
  - id: intervals
    type:
      - 'null'
      - string
    doc: The interval and reference sequence to request
    inputBinding:
      position: 101
      prefix: --intervals
  - id: notag
    type:
      - 'null'
      - type: array
        items: string
    doc: A tag which should be excluded.
    inputBinding:
      position: 101
      prefix: --notag
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: A tag which should be included.
    inputBinding:
      position: 101
      prefix: --tag
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
  - id: reader_threads
    type:
      - 'null'
      - int
    doc: How many simultaneous threads to use when reading data from an htsget 
      response;higher values may improve performance when network latency is an 
      issue.
    inputBinding:
      position: 101
      prefix: --reader-threads
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
    doc: Output file.
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
