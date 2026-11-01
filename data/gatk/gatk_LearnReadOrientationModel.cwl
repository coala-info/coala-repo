cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- LearnReadOrientationModel
label: gatk_LearnReadOrientationModel
doc: 'Get the maximum likelihood estimates of artifact prior probabilities in the orientation bias mixture
  model filter


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  doc: One or more .tar.gz containing outputs of CollectF1R2Counts
  inputBinding:
    position: 1
- id: output
  type: string
  doc: tar.gz of artifact prior tables
  inputBinding:
    position: 1
    prefix: --output
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 1
- id: convergence_threshold
  type:
  - 'null'
  - double
  doc: Stop the EM when the distance between parameters between iterations falls below this value
  inputBinding:
    position: 1
    prefix: --convergence-threshold
- id: gatk_config_file
  type:
  - 'null'
  - File
  doc: A configuration file to use with the GATK.
  inputBinding:
    position: 1
    prefix: --gatk-config-file
- id: gcs_max_retries
  type:
  - 'null'
  - int
  doc: If the GCS bucket channel errors out, how many times it will attempt to re-initiate the connection
  inputBinding:
    position: 1
    prefix: --gcs-max-retries
- id: gcs_project_for_requester_pays
  type:
  - 'null'
  - string
  doc: Project to bill when accessing "requester pays" buckets. If unset, these buckets cannot be accessed.
    User must have storage.buckets.get permission on the bucket being accessed.
  inputBinding:
    position: 1
    prefix: --gcs-project-for-requester-pays
- id: max_depth
  type:
  - 'null'
  - int
  doc: sites with depth higher than this value will be grouped
  inputBinding:
    position: 1
    prefix: --max-depth
- id: num_em_iterations
  type:
  - 'null'
  - int
  doc: give up on EM after this many iterations
  inputBinding:
    position: 1
    prefix: --num-em-iterations
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 1
    prefix: --QUIET
- id: tmp_dir
  type:
  - 'null'
  - string
  doc: Temp directory to use.
  inputBinding:
    position: 1
    prefix: --tmp-dir
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
  inputBinding:
    position: 1
    prefix: --use-jdk-deflater
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Whether to use the JdkInflater (as opposed to IntelInflater)
  inputBinding:
    position: 1
    prefix: --use-jdk-inflater
- id: verbosity
  type:
  - 'null'
  - string
  doc: Control verbosity of logging.
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: output_file
  type: File
  doc: tar.gz of artifact prior tables
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
