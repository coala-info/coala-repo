cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- TrainVariantAnnotationsModel
label: gatk_TrainVariantAnnotationsModel
doc: 'Trains a model for scoring variant calls based on site-level annotations.


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: annotations_hdf5
  type: File
  doc: HDF5 file containing annotations extracted with ExtractVariantAnnotations.
  inputBinding:
    position: 1
    prefix: --annotations-hdf5
- id: output
  type: string
  doc: Output prefix.
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
- id: hyperparameters_json
  type:
  - 'null'
  - File
  doc: JSON file containing hyperparameters. Optional if the PYTHON_IFOREST backend is used (if not specified,
    a default set of hyperparameters will be used); otherwise required.
  inputBinding:
    position: 1
    prefix: --hyperparameters-json
- id: mode
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --mode
  doc: Variant types for which to train models. Duplicate values will be ignored.
  inputBinding:
    position: 1
- id: model_backend
  type:
  - 'null'
  - string
  doc: Backend to use for training models. JAVA_BGMM will use a pure Java implementation (ported from
    Python scikit-learn) of the Bayesian Gaussian Mixture Model. PYTHON_IFOREST will use the Python scikit-learn
    implementation of the IsolationForest method and will require that the corresponding Python dependencies
    are present in the environment. PYTHON_SCRIPT will use the script specified by the python-script argument.
    See the tool documentation for more details.
  inputBinding:
    position: 1
    prefix: --model-backend
- id: python_script
  type:
  - 'null'
  - File
  doc: Python script used for specifying a custom scoring backend. If provided, model-backend must also
    be set to PYTHON_SCRIPT.
  inputBinding:
    position: 1
    prefix: --python-script
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
- id: unlabeled_annotations_hdf5
  type:
  - 'null'
  - File
  doc: HDF5 file containing annotations extracted with ExtractVariantAnnotations. If specified, a positive-unlabeled
    modeling approach will be used; otherwise, a positive-only modeling approach will be used.
  inputBinding:
    position: 1
    prefix: --unlabeled-annotations-hdf5
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
  type: File[]
  doc: Output prefix.
  outputBinding:
    glob: $(inputs.output)*
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
