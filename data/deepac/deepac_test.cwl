cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac test
label: deepac_test
doc: "Test the deepac tool\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Test all functions.
    inputBinding:
      position: 101
      prefix: --all
  - id: explain
    type:
      - 'null'
      - boolean
    doc: Test explain workflows.
    inputBinding:
      position: 101
      prefix: --explain
  - id: gpus
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GPU devices to use. Default: all'
    inputBinding:
      position: 101
      prefix: --gpus
  - id: gwpa
    type:
      - 'null'
      - boolean
    doc: Test gwpa workflows.
    inputBinding:
      position: 101
      prefix: --gwpa
  - id: input_modes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Input modes to test: memory, sequence and/or tfdata.\n                 \
      \       Default: all."
    inputBinding:
      position: 101
      prefix: --input-modes
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Don't delete previous test output.
    inputBinding:
      position: 101
      prefix: --keep
  - id: large
    type:
      - 'null'
      - boolean
    doc: Test a larger, more complex custom model.
    inputBinding:
      position: 101
      prefix: --large
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores. Default: all.'
    inputBinding:
      position: 101
      prefix: --n-cpus
  - id: no_check
    type:
      - 'null'
      - boolean
    doc: Disable additivity check.
    inputBinding:
      position: 101
      prefix: --no-check
  - id: offline
    type:
      - 'null'
      - boolean
    doc: "Perform offline tests (don't fetch the pretrained\nmodels)."
    inputBinding:
      position: 101
      prefix: --offline
  - id: quick
    type:
      - 'null'
      - boolean
    doc: "Don't test heavy models (e.g. on low-memory machines\nor when no GPU available)."
    inputBinding:
      position: 101
      prefix: --quick
  - id: scale
    type:
      - 'null'
      - float
    doc: 'Generate s*1024 reads for testing (Default: s=1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --scale
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_test.out
