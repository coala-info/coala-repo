cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- NVScoreVariants
label: gatk_NVScoreVariants
doc: 'Annotate a VCF with scores from a PyTorch-based Convolutional Neural Network (CNN)


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: output
  type: string
  doc: Output VCF file
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
  inputBinding:
    position: 1
    prefix: --reference
- id: variant
  type: File
  doc: Input VCF file containing variants to score
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --variant
- id: accelerator
  type:
  - 'null'
  - string
  doc: Type of hardware accelerator to use (auto, cpu, cuda, mps, tpu, etc)
  inputBinding:
    position: 1
    prefix: --accelerator
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
- id: batch_size
  type:
  - 'null'
  - int
  doc: Batch size
  inputBinding:
    position: 1
    prefix: --batch-size
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
- id: input
  type:
  - 'null'
  - File
  doc: BAM file containing reads, if using the 2D model
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
  inputBinding:
    position: 1
    prefix: --input
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 1
    prefix: --QUIET
- id: random_seed
  type:
  - 'null'
  - int
  doc: Seed to initialize the random number generator
  inputBinding:
    position: 1
    prefix: --random-seed
- id: tensor_type
  type:
  - 'null'
  - string
  doc: 'Name of the tensors to generate: reference for 1D reference tensors and read_tensor for 2D tensors.'
  inputBinding:
    position: 1
    prefix: --tensor-type
- id: tmp_dir
  type:
  - 'null'
  - string
  doc: Temp directory to use.
  inputBinding:
    position: 1
    prefix: --tmp-dir
- id: tmp_file
  type:
  - 'null'
  - string
  doc: The temporary VCF-like file where variants scores will be written
  inputBinding:
    position: 1
    prefix: --tmp-file
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
  doc: Output VCF file
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: tmp_file_file
  type:
  - 'null'
  - File
  doc: The temporary VCF-like file where variants scores will be written
  outputBinding:
    glob: $(inputs.tmp_file)
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
