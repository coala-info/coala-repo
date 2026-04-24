cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi test
label: kipoi_test
doc: "script to test model zoo submissions. Example usage: `kipoi test\nmodel/directory`,
  where `model/directory` is the path to a directory\ncontaining a model.yaml file.\n\
  \nTool homepage: https://github.com/kipoi/kipoi"
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
  - id: expect
    type:
      - 'null'
      - File
    doc: "File path to the hdf5 file of predictions produced by\nkipoi test -o file.h5
      or kipoi predict -o file.h5\n--keep_inputs. Overrides test.expect in model.yaml"
    inputBinding:
      position: 102
      prefix: --expect
  - id: keep_metadata
    type:
      - 'null'
      - boolean
    doc: Keep the metadata in the output file.
    inputBinding:
      position: 102
      prefix: --keep_metadata
  - id: skip_expect
    type:
      - 'null'
      - boolean
    doc: "Skip validating the expected predictions if\ntest.expect field is specified
      under model.yaml"
    inputBinding:
      position: 102
      prefix: --skip-expect
  - id: source
    type:
      - 'null'
      - string
    doc: "Model source to use (default=dir). Specified in\n~/.kipoi/config.yaml under
      model_sources. When 'dir'\nis used, use the local directory path when specifying\n\
      the model/dataloader."
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output hdf5 file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
