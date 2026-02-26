cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_search
label: ibridges_search
doc: "Search for dataobjects and collections.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_path
    type:
      - 'null'
      - string
    doc: Remote path to search inn. The path itself will not be matched.
    inputBinding:
      position: 1
  - id: checksum
    type:
      - 'null'
      - string
    doc: Checksum of the data objects to be found.
    inputBinding:
      position: 102
      prefix: --checksum
  - id: item_type
    type:
      - 'null'
      - string
    doc: Use data_object or collection to show only items of that type. By 
      default all items are returned.
    inputBinding:
      position: 102
      prefix: --item_type
  - id: metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: Constrain the results using metadata, see examples. Can be used 
      multiple times.
    inputBinding:
      position: 102
      prefix: --metadata
  - id: path_pattern
    type:
      - 'null'
      - string
    doc: Pattern of the path constraint. For example, use '%.txt' to find all 
      data objects and collections that end with .txt. You can also use the name
      of the item here to find all items with that name.
    inputBinding:
      position: 102
      prefix: --path-pattern
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_search.out
