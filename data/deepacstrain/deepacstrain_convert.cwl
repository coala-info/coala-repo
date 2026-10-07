cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
label: deepacstrain_convert
doc: "Convert and compile a model to an equivalent (rebuild the network using a training config).\n\
  \nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.model)
        writable: true
arguments:
  - position: 2
    valueFrom: convert
inputs:
  - id: debug_no_eager
    type:
      - 'null'
      - boolean
    doc: Disable eager mode (global option).
    inputBinding:
      position: 1
      prefix: --debug-no-eager
  - id: debug_tf
    type:
      - 'null'
      - int
    doc: 'Set tensorflow debug info verbosity level. 0 = max, 3 = min. Default: 2 (errors)
      (global option).'
    inputBinding:
      position: 1
      prefix: --debug-tf
  - id: debug_device
    type:
      - 'null'
      - boolean
    doc: Enable verbose device placement information (global option).
    inputBinding:
      position: 1
      prefix: --debug-device
  - id: force_cpu
    type:
      - 'null'
      - boolean
    doc: Use a CPU even if GPUs are available (global option).
    inputBinding:
      position: 1
      prefix: --force-cpu
  - id: tpu
    type:
      - 'null'
      - string
    doc: 'TPU name: ''colab'' for Google Colab, or name of your TPU on GCE (global option).'
    inputBinding:
      position: 1
      prefix: --tpu
  - id: config
    type: File
    doc: Training config file.
    inputBinding:
      position: 10
  - id: model
    type: File
    doc: 'Saved model. Staged writable: the converted model is written beside it as <model>_converted.h5.'
    inputBinding:
      position: 11
      valueFrom: $(self.basename)
  - id: weights
    type:
      - 'null'
      - boolean
    doc: Use prepared weights instead of the model file.
    inputBinding:
      position: 3
      prefix: --weights
  - id: init
    type:
      - 'null'
      - boolean
    doc: Initialize a random model from config.
    inputBinding:
      position: 3
      prefix: --init
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_model
    type:
      type: array
      items: File
    doc: Converted model (<model>_converted.h5) and saved weights (<model>_weights.h5)
    outputBinding:
      glob:
        - '*_converted.h5'
        - '*_weights.h5'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain_convert.out
