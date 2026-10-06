cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - search
label: bigsi_search
doc: "Search for a sequence in a BIGSI index\n\nTool homepage: https://github.com/Phelimb/BIGSI"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index)
        writable: true
inputs:
  - id: seq
    type: string
    doc: Query sequence
    inputBinding:
      position: 1
  - id: config
    type: File
    loadContents: true
    doc: BIGSI configuration YAML file; its storage-config filename names the index
    inputBinding:
      position: 102
      prefix: --config
  - id: index
    type:
      - File
      - Directory
    doc: BIGSI index (file or folder) named in the config file
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum fraction of query k-mers found (default 1.0)
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_search.out
