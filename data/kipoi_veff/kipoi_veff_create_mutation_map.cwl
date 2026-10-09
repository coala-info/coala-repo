cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - veff
  - create_mutation_map
label: kipoi_veff_create_mutation_map
doc: "Calculate variant effect scores for mutation map plotting.\n\nTool homepage: https://github.com/kipoi/kipoi-veff"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: model
    type:
      - string
      - Directory
    doc: Model name; with source dir give the local model directory.
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: "Model source to use: kipoi, github-permalink or dir."
    inputBinding:
      position: 0
      prefix: --source
  - id: dataloader
    type:
      - 'null'
      - string
    doc: "Dataloader name. If not specified, the model's defaultDataLoader will be used."
    inputBinding:
      position: 0
      prefix: --dataloader
  - id: dataloader_source
    type:
      - 'null'
      - string
    doc: "Dataloader source."
    inputBinding:
      position: 0
      prefix: --dataloader_source
  - id: dataloader_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "DataLoader arguments either as a json string or as a file path to a json file."
    inputBinding:
      position: 0
      prefix: --dataloader_args
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size to use in prediction."
    inputBinding:
      position: 0
      prefix: --batch_size
  - id: num_workers
    type:
      - 'null'
      - int
    doc: "Number of parallel workers for loading the dataset."
    inputBinding:
      position: 0
      prefix: --num_workers
  - id: scores
    type:
      - 'null'
      - type: array
        items: string
    doc: "Scoring method(s) to be used; only methods selected in the model yaml file are available, except diff which is always available."
    inputBinding:
      position: 0
      prefix: --scores
  - id: score_kwargs
    type:
      - 'null'
      - type: array
        items: string
    doc: "JSON definition of the kwargs for the scoring functions selected in scores, as a JSON string or a .json file path, in the same order as scores."
    inputBinding:
      position: 0
      prefix: --score_kwargs
  - id: seq_length
    type:
      - 'null'
      - int
    doc: "Model input sequence length, needed if the model has no pre-defined input sequence length."
    inputBinding:
      position: 0
      prefix: --seq_length
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: "Run kipoi predict in the appropriate singularity container."
    inputBinding:
      position: 0
      prefix: --singularity
  - id: regions_file
    type:
      - 'null'
      - File
    doc: "Region definition as VCF or bed file. Not a required input."
    inputBinding:
      position: 0
      prefix: --regions_file
  - id: install_req
    type:
      - 'null'
      - boolean
    doc: "Install required packages from requirements.txt."
    inputBinding:
      position: 0
      prefix: --install_req
  - id: output_path
    type: string
    doc: "Output HDF5 file. To be used as input for plotting."
    inputBinding:
      position: 0
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Mutation map HDF5 file
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi_veff:0.3.1--pyh145b6a8_1
