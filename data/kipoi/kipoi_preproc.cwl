cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - preproc
label: kipoi_preproc
doc: "Run the dataloader and save the output to an hdf5 file.\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: dataloader
    type: string
    doc: Dataloader name.
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size to use in data loading
    inputBinding:
      position: 102
      prefix: --batch_size
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
  - id: keep_metadata
    type:
      - 'null'
      - boolean
    doc: Keep the metadata in the output file.
    inputBinding:
      position: 102
      prefix: --keep_metadata
  - id: num_workers
    type:
      - 'null'
      - int
    doc: Number of parallel workers for loading the dataset
    inputBinding:
      position: 102
      prefix: --num_workers
  - id: source
    type:
      - 'null'
      - string
    doc: "Dataloader source to use. Specified in\n                        ~/.kipoi/config.yaml
      under model_sources. 'dir' is an\n                        additional source
      referring to the local folder."
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: output
    type: File
    doc: Output hdf5 file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
