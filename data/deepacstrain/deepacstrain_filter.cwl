cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
label: deepacstrain_filter
doc: "Filter reads in a fasta file by pathogenic potential predictions.\n\nTool homepage:\
  \ https://gitlab.com/rki_bioinformatics/DeePaC"
arguments:
  - position: 2
    valueFrom: filter
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
  - id: predictions
    type: File
    doc: Predictions in matching order [.npy].
    inputBinding:
      position: 11
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold [default=0.5].
    inputBinding:
      position: 3
      prefix: --threshold
  - id: potentials
    type:
      - 'null'
      - boolean
    doc: Print pathogenic potential values in .fasta headers.
    inputBinding:
      position: 3
      prefix: --potentials
  - id: output
    type:
      - 'null'
      - string
    doc: Output file path [.fasta].
    default: filtered.fasta
    inputBinding:
      position: 3
      prefix: --output
  - id: std
    type:
      - 'null'
      - File
    doc: Standard deviations of predictions if MC dropout used.
    inputBinding:
      position: 3
      prefix: --std
  - id: precision
    type:
      - 'null'
      - int
    doc: Format pathogenic potentials to given precision [default=3].
    inputBinding:
      position: 3
      prefix: --precision
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: filtered_fasta
    type: File
    doc: Reads at or above the threshold [.fasta]
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain_filter.out
