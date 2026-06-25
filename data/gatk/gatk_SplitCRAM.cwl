cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - SplitCRAM
label: gatk_SplitCRAM
doc: Splits CRAM files efficiently by taking advantage of their container based 
  structure
inputs:
  - id: input
    type: File
    doc: input cram file to split
    inputBinding:
      position: 101
      prefix: --input
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
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
  - id: output
    type:
      - 'null'
      - string
    doc: output cram file template. should contain %d, which will be replaced by
      shard index
    inputBinding:
      position: 101
      prefix: --output
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: shard_max_output_count
    type:
      - 'null'
      - int
    doc: maximal number of output shards to output.
    inputBinding:
      position: 101
      prefix: --shard-max-output-count
  - id: shard_records
    type:
      - 'null'
      - int
    doc: minimum threshold for number of records per shard.
    inputBinding:
      position: 101
      prefix: --shard-records
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
    type:
      - 'null'
      - File[]
    doc: output cram file template. should contain %d, which will be replaced by
      shard index
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
