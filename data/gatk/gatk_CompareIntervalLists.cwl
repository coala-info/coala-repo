cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CompareIntervalLists
label: gatk_CompareIntervalLists
doc: Compare two interval lists to see if they are equal
inputs:
  - id: interval_list_1
    type: string
    doc: Undocumented option
    inputBinding:
      position: 101
      prefix: --L
  - id: interval_list_2
    type: string
    doc: Undocumented option
    inputBinding:
      position: 101
      prefix: --L2
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
stdout: gatk_CompareIntervalLists.out
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
