cwlVersion: v1.2
class: CommandLineTool
baseCommand: instanovo convert
label: instanovo_convert
doc: "Convert data to SpectrumDataFrame and save as *.parquet file(s).\n\nTool homepage:
  https://github.com/instadeepai/instanovo"
inputs:
  - id: source
    type: string
    doc: Source file(s)
    inputBinding:
      position: 1
  - id: target
    type: Directory
    doc: Target folder to save data shards
    inputBinding:
      position: 2
  - id: add_spectrum_id
    type:
      - 'null'
      - boolean
    doc: Add spectrum id column
    inputBinding:
      position: 103
      prefix: --add-spectrum-id
  - id: is_annotated
    type:
      - 'null'
      - boolean
    doc: whether dataset is annotated
    inputBinding:
      position: 103
      prefix: --is-annotated
  - id: max_charge
    type:
      - 'null'
      - int
    doc: Maximum charge to filter out
    inputBinding:
      position: 103
      prefix: --max-charge
  - id: name
    type: string
    doc: Name of saved dataset
    inputBinding:
      position: 103
      prefix: --name
  - id: partition
    type: string
    doc: Partition of saved dataset
    inputBinding:
      position: 103
      prefix: --partition
  - id: shard_size
    type:
      - 'null'
      - int
    doc: Length of saved data shards
    inputBinding:
      position: 103
      prefix: --shard-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
stdout: instanovo_convert.out
