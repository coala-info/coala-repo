cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinf train
label: dinf_train
doc: "Train a discriminator.\n\nTool homepage: https://github.com/RacimoLab/dinf"
inputs:
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of full passes over the training dataset when training the 
      discriminator.
    inputBinding:
      position: 101
      prefix: --epochs
  - id: model
    type:
      - 'null'
      - File
    doc: Python script from which to import the variable "dinf_model". This is a
      dinf.DinfModel object that describes the model components. See the 
      examples/ folder of the git repository for example models. 
      https://github.com/RacimoLab/dinf
    inputBinding:
      position: 101
      prefix: --model
  - id: parallelism
    type:
      - 'null'
      - int
    doc: Number of processes to use for parallelising calls to the DinfModel's 
      generator_func and target_func. If not specified, all CPU cores will be 
      used. The number of cores used for CPU-based neural networks is not set 
      with this parameter---instead use the`taskset` command. See 
      https://github.com/google/jax/issues/1539
    inputBinding:
      position: 101
      prefix: --parallelism
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable output. Only ERROR and CRITICAL messages are printed.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator. CPU-based training is expected to
      produce deterministic results. Results may differ between CPU and GPU 
      trained networks for the same seed value. Also note that operations on a 
      GPU are not fully determinstic, so training or applying a neural network 
      twice with the same seed value will not produce identical results.
    inputBinding:
      position: 101
      prefix: --seed
  - id: test_replicates
    type:
      - 'null'
      - int
    doc: Size of the test dataset used to evaluate the discriminator after each 
      training epoch.
    inputBinding:
      position: 101
      prefix: --test-replicates
  - id: training_replicates
    type:
      - 'null'
      - int
    doc: Size of the dataset used to train the discriminator.
    inputBinding:
      position: 101
      prefix: --training-replicates
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity. Specify once for INFO messages and twice for DEBUG 
      messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: discriminator
    type:
      - 'null'
      - File
    doc: Output file where the discriminator will be saved.
    outputBinding:
      glob: $(inputs.discriminator)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
