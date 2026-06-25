cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CallCopyRatioSegments
label: gatk_CallCopyRatioSegments
doc: Calls copy-ratio segments as amplified, deleted, or copy-number neutral
inputs:
  - id: input
    type: File
    doc: Input file containing copy-ratio segments (.cr.seg output of 
      ModelSegments).
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output file for called copy-ratio segments.
    inputBinding:
      position: 101
      prefix: --output
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: calling_copy_ratio_z_score_threshold
    type:
      - 'null'
      - float
    doc: Threshold on z-score of non-log2 copy ratio used for calling segments.
    inputBinding:
      position: 101
      prefix: --calling-copy-ratio-z-score-threshold
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
  - id: neutral_segment_copy_ratio_lower_bound
    type:
      - 'null'
      - float
    doc: Lower bound on non-log2 copy ratio used for determining copy-neutral 
      segments.
    inputBinding:
      position: 101
      prefix: --neutral-segment-copy-ratio-lower-bound
  - id: neutral_segment_copy_ratio_upper_bound
    type:
      - 'null'
      - float
    doc: Upper bound on non-log2 copy ratio used for determining copy-neutral 
      segments.
    inputBinding:
      position: 101
      prefix: --neutral-segment-copy-ratio-upper-bound
  - id: outlier_neutral_segment_copy_ratio_z_score_threshold
    type:
      - 'null'
      - float
    doc: Threshold on z-score of non-log2 copy ratio used for determining 
      outlier copy-neutral segments.
    inputBinding:
      position: 101
      prefix: --outlier-neutral-segment-copy-ratio-z-score-threshold
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
    doc: Output file for called copy-ratio segments.
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
