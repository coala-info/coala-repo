cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - search_toolshed
label: nebulizer_search_toolshed
doc: "Search for repositories on a Galaxy toolshed.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: query_string
    type: string
    doc: Query string to search for
    inputBinding:
      position: 1
  - id: galaxy
    type:
      - 'null'
      - string
    doc: Check if tool repositories are installed in GALAXY instance
    inputBinding:
      position: 102
      prefix: --galaxy
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: Use a long listing format that includes tool descriptions
    inputBinding:
      position: 102
      prefix: -l
  - id: toolshed
    type:
      - 'null'
      - string
    doc: Specify a toolshed URL to search, or 'main' (the main Galaxy toolshed, 
      the default) or 'test' (the test Galaxy toolshed)
    default: main
    inputBinding:
      position: 102
      prefix: --toolshed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_search_toolshed.out
