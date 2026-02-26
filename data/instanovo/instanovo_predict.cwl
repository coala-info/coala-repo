cwlVersion: v1.2
class: CommandLineTool
baseCommand: instanovo predict
label: instanovo_predict
doc: "Run predictions with InstaNovo and optionally refine with InstaNovo+.\nFirst
  with the transformer-based InstaNovo model and then optionally refine\nthem with
  the diffusion based InstaNovo+ model.\n\nTool homepage: https://github.com/instadeepai/instanovo"
inputs:
  - id: overrides
    type:
      - 'null'
      - type: array
        items: string
    doc: Overrides for configuration parameters
    inputBinding:
      position: 1
  - id: config_name
    type:
      - 'null'
      - string
    doc: The name of the config (usually the file name without the .yaml 
      extension).
    inputBinding:
      position: 102
      prefix: --config-name
  - id: config_path
    type:
      - 'null'
      - string
    doc: Relative path to config directory.
    inputBinding:
      position: 102
      prefix: --config-path
  - id: data_path
    type:
      - 'null'
      - string
    doc: Path to input data file
    inputBinding:
      position: 102
      prefix: --data-path
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: Do de novo predictions or evaluate an annotated file with peptide 
      sequences?
    inputBinding:
      position: 102
      prefix: --denovo
  - id: evaluation
    type:
      - 'null'
      - boolean
    doc: Do de novo predictions or evaluate an annotated file with peptide 
      sequences?
    inputBinding:
      position: 102
      prefix: --evaluation
  - id: instanovo_model
    type:
      - 'null'
      - string
    doc: Either a model ID or a path to an Instanovo checkpoint file (.ckpt 
      format)
    inputBinding:
      position: 102
      prefix: --instanovo-model
  - id: instanovo_plus_model
    type:
      - 'null'
      - string
    doc: Either a model ID or a path to an Instanovo+ checkpoint file (.ckpt 
      format)
    inputBinding:
      position: 102
      prefix: --instanovo-plus-model
  - id: no_refinement
    type:
      - 'null'
      - boolean
    doc: Refine the predictions of the transformer-based InstaNovo model with 
      the diffusion-based InstaNovo+ model?
    default: false
    inputBinding:
      position: 102
      prefix: --no-refinement
  - id: with_refinement
    type:
      - 'null'
      - boolean
    doc: Refine the predictions of the transformer-based InstaNovo model with 
      the diffusion-based InstaNovo+ model?
    default: true
    inputBinding:
      position: 102
      prefix: --with-refinement
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Path to output file.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
