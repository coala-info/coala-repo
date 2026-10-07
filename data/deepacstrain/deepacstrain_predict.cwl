cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
label: deepacstrain_predict
doc: "Predict pathogenic potentials of DNA reads (DeePaC-strain bacterial strain models) using\
  \ a trained model.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 2
    valueFrom: predict
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
  - id: input
    type: File
    doc: Input file path [.fasta].
    inputBinding:
      position: 10
  - id: array
    type:
      - 'null'
      - boolean
    doc: Use .npy input instead.
    inputBinding:
      position: 3
      prefix: --array
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Use the sensitive model.
    inputBinding:
      position: 3
      prefix: --sensitive
  - id: rapid
    type:
      - 'null'
      - boolean
    doc: Use the rapid CNN model.
    inputBinding:
      position: 3
      prefix: --rapid
  - id: custom
    type:
      - 'null'
      - File
    doc: Use the user-supplied, already compiled CUSTOM model.
    inputBinding:
      position: 3
      prefix: --custom
  - id: output
    type:
      - 'null'
      - string
    doc: Output file path [.npy].
    default: predictions.npy
    inputBinding:
      position: 3
      prefix: --output
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores. Default: all.'
    inputBinding:
      position: 3
      prefix: --n-cpus
  - id: gpus
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GPU devices to use (comma-separated). Default: all'
    inputBinding:
      position: 3
      prefix: --gpus
  - id: rc_check
    type:
      - 'null'
      - boolean
    doc: Check RC-constraint compliance (requires .npy input).
    inputBinding:
      position: 3
      prefix: --rc-check
  - id: plot_kind
    type:
      - 'null'
      - string
    doc: Plot kind for the RC-constraint compliance check.
    inputBinding:
      position: 3
      prefix: --plot-kind
  - id: alpha
    type:
      - 'null'
      - float
    doc: Alpha value for the RC-constraint compliance check plot.
    inputBinding:
      position: 3
      prefix: --alpha
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of replicates for MC uncertainty estimation.
    inputBinding:
      position: 3
      prefix: --replicates
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: predictions
    type:
      - 'null'
      - File
    doc: Predicted pathogenic potentials [.npy]
    outputBinding:
      glob: $(inputs.output)
  - id: extra_outputs
    type:
      type: array
      items: File
    doc: Other files named after the output path (MC dropout standard deviations, RC-check
      plots)
    outputBinding:
      glob:
        - $(inputs.output.replace(/\.npy$/, ''))-std.npy
        - '*.png'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain_predict.out
