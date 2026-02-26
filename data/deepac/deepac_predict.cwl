cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac_predict
label: deepac_predict
doc: "Predicts the presence of bacteriophages in DNA sequences.\n\nTool homepage:
  https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: input
    type: File
    doc: Input file path [.fasta].
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: Alpha value for the RC-constraint compliance check plot.
    inputBinding:
      position: 102
      prefix: --alpha
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size.
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: custom_model
    type:
      - 'null'
      - string
    doc: Use the user-supplied, already compiled CUSTOM model.
    inputBinding:
      position: 102
      prefix: --custom
  - id: get_logits
    type:
      - 'null'
      - boolean
    doc: Return logits instead of the final predictions.
    inputBinding:
      position: 102
      prefix: --get-logits
  - id: gpus
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GPU devices to use (comma-separated). Default: all'
    inputBinding:
      position: 102
      prefix: --gpus
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores. Default: all.'
    inputBinding:
      position: 102
      prefix: --n-cpus
  - id: plot_kind
    type:
      - 'null'
      - string
    doc: Plot kind for the RC-constraint compliance check.
    inputBinding:
      position: 102
      prefix: --plot-kind
  - id: rapid_model
    type:
      - 'null'
      - boolean
    doc: Use the rapid CNN model.
    inputBinding:
      position: 102
      prefix: --rapid
  - id: rc_check
    type:
      - 'null'
      - boolean
    doc: Check RC-constraint compliance (requires .npy input).
    inputBinding:
      position: 102
      prefix: --rc-check
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of replicates for MC uncertainty estimation.
    inputBinding:
      position: 102
      prefix: --replicates
  - id: sensitive_model
    type:
      - 'null'
      - boolean
    doc: Use the sensitive model.
    inputBinding:
      position: 102
      prefix: --sensitive
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Automatically trim the sequences to the read length specified by the 
      input size of the model (if using fasta input).
    inputBinding:
      position: 102
      prefix: --trim
  - id: use_npy_input
    type:
      - 'null'
      - boolean
    doc: Use .npy input instead.
    inputBinding:
      position: 102
      prefix: --array
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path [.npy].
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
