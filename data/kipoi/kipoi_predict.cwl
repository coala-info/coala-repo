cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi predict
label: kipoi_predict
doc: "Run the model prediction.\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model
    type: string
    doc: Model name.
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size to use in prediction
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: dataloader
    type:
      - 'null'
      - string
    doc: "Dataloader name. If not specified, the model's\n                       \
      \ defaultDataLoader will be used"
    inputBinding:
      position: 102
      prefix: --dataloader
  - id: dataloader_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "DataLoader arguments either as a json string:'{\"arg1\":\n             \
      \           1} or as a file path to a json file"
    inputBinding:
      position: 102
      prefix: --dataloader_args
  - id: dataloader_source
    type:
      - 'null'
      - string
    doc: Dataloader source
    inputBinding:
      position: 102
      prefix: --dataloader_source
  - id: keep_inputs
    type:
      - 'null'
      - boolean
    doc: Keep the inputs in the output file.
    inputBinding:
      position: 102
      prefix: --keep_inputs
  - id: keep_metadata
    type:
      - 'null'
      - boolean
    doc: Keep the metadata in the output file.
    inputBinding:
      position: 102
      prefix: --keep_metadata
  - id: layer
    type:
      - 'null'
      - string
    doc: "Which output layer to use to make the predictions. If\n                \
      \        specified,`model.predict_activation_on_batch` will be\n           \
      \             invoked instead of `model.predict_on_batch`"
    inputBinding:
      position: 102
      prefix: --layer
  - id: num_workers
    type:
      - 'null'
      - int
    doc: Number of parallel workers for loading the dataset
    inputBinding:
      position: 102
      prefix: --num_workers
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: "Run `kipoi predict` in the appropriate singularity\n                   \
      \     container. Containters will get downloaded to\n                      \
      \  ~/.kipoi/envs/ or to $SINGULARITY_CACHEDIR if set"
    inputBinding:
      position: 102
      prefix: --singularity
  - id: source
    type:
      - 'null'
      - string
    doc: "Model source to use (default=kipoi). Specified in\n                    \
      \    ~/.kipoi/config.yaml under model_sources. When 'dir'\n                \
      \        is used, use the local directory path when specifying\n           \
      \             the model/dataloader."
    default: kipoi
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output files. File format is inferred from the file\n                path
      ending. Available file formats are: .h5, .hdf5,\n                .pq, .parquet,
      .zarr, .pqt, .tsv, .bed"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
