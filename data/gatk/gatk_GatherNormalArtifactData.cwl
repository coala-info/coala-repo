cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - GatherNormalArtifactData
label: gatk_GatherNormalArtifactData
doc: Combine output files from GetNormalArtifactData in the order defined by a 
  sequence dictionary
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: an output of GetNormalArtifactData  This argument must be specified at 
      least once.
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 101
      prefix: --output
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line  This
      argument may be specified 0 or more times.
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
      these buckets cannot be accessed. User must have storage.buckets.get 
      permission on the bucket being accessed.
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
  - id: output_output
    type: File
    doc: output
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
