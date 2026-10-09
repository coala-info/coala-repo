cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - env
  - export
label: kipoi_env_export
doc: "Export the environment.yaml file for a specific model.\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model
    type:
      type: array
      items:
        - string
        - Directory
    doc: Model name(s). You can use <source>::<model> to use models from different
      sources. A model directory can be given together with source dir.
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: "Model source to use (default=kipoi): kipoi, github-permalink or dir. When 'dir' is used, give the local model directory as model."
    inputBinding:
      position: 0
      prefix: --source
  - id: dataloader
    type:
      - 'null'
      - type: array
        items: string
    doc: Dataloader name(s). If not specified, the model's default dataloader will be used.
    inputBinding:
      position: 0
      prefix: --dataloader
  - id: vep
    type:
      - 'null'
      - string
    doc: This argument is deprecated. Please use https://github.com/kipoi/kipoi-veff2 directly.
    inputBinding:
      position: 0
      prefix: --vep
  - id: interpret
    type:
      - 'null'
      - boolean
    doc: Include also the dependencies for the kipoi-interpret package
    inputBinding:
      position: 0
      prefix: --interpret
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: Use gpu-compatible dependencies, for example tensorflow-gpu instead of tensorflow
    inputBinding:
      position: 0
      prefix: --gpu
  - id: env
    type:
      - 'null'
      - string
    doc: Environment name
    inputBinding:
      position: 0
      prefix: --env
  - id: output_path
    type: string
    doc: Output file name
    inputBinding:
      position: 0
      prefix: --output
outputs:
  - id: output
    type: File
    doc: The exported conda environment file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
