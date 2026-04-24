cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinf predict
label: dinf_predict
doc: "Make predictions using a trained discriminator.\n\nTool homepage: https://github.com/RacimoLab/dinf"
inputs:
  - id: discriminator
    type:
      - 'null'
      - File
    doc: File containing discriminator network weights.
    inputBinding:
      position: 101
      prefix: --discriminator
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
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of theta replicates to generate and predict with the 
      discriminator.
    inputBinding:
      position: 101
      prefix: --replicates
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
  - id: target
    type:
      - 'null'
      - boolean
    doc: Sample features from the target dataset.
    inputBinding:
      position: 101
      prefix: --target
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
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output data, matching thetas to discriminator predictions.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
