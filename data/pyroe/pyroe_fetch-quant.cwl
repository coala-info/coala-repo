cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyroe
  - fetch-quant
label: pyroe_fetch-quant
doc: "The ids of the datasets to fetch\n\nTool homepage: https://github.com/COMBINE-lab/pyroe"
inputs:
  - id: dataset_ids
    type:
      type: array
      items: string
    doc: The ids of the datasets to fetch
    inputBinding:
      position: 1
  - id: delete_tar
    type:
      - 'null'
      - boolean
    doc: A flag indicates whether fetched tar files stored in the quant_tar 
      directory under the provided fetch_dir should be deleted.
    inputBinding:
      position: 102
      prefix: --delete-tar
  - id: fetch_dir
    type:
      - 'null'
      - string
    doc: The path to a directory for storing fetched datasets.
    inputBinding:
      position: 102
      prefix: --fetch-dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: A flag indicates whether existing datasets will be redownloaded by 
      force.
    inputBinding:
      position: 102
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: A flag indicates whether help messaged should not be printed.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fetched_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the fetched datasets
    outputBinding:
      glob: $(inputs.fetch_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
stdout: pyroe_fetch-quant.out
