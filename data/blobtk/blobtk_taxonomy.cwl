cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtk_taxonomy
label: blobtk_taxonomy
doc: "Process a taxonomy and lookup lineages, or start the API server with --api\n\
  \nTool homepage: https://github.com/genomehubs/blobtk"
inputs:
  - id: api
    type:
      - 'null'
      - boolean
    doc: '[experimental] Start the taxonomy API server instead of running a one-off
      merge/output'
    inputBinding:
      position: 101
      prefix: --api
  - id: base_id
    type:
      - 'null'
      - string
    doc: Base taxon for filtered taxonomy lineages
    inputBinding:
      position: 101
      prefix: --base-id
  - id: config
    type:
      - 'null'
      - File
    doc: Path to YAML format config file
    inputBinding:
      position: 101
      prefix: --config
  - id: genomehubs_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to match to taxIDs - Experimental
    inputBinding:
      position: 101
      prefix: --genomehubs_files
  - id: leaf_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Leaf taxon/taxa for filtered taxonomy
    inputBinding:
      position: 101
      prefix: --leaf-id
  - id: port
    type:
      - 'null'
      - int
    doc: Port to run the API server on (if --api is set)
    default: 3000
    inputBinding:
      position: 101
      prefix: --port
  - id: root_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Root taxon/taxa for filtered taxonomy
    inputBinding:
      position: 101
      prefix: --root-id
  - id: taxdump
    type:
      - 'null'
      - File
    doc: Path to backbone taxonomy file/directory
    inputBinding:
      position: 101
      prefix: --taxdump
  - id: taxonomy_format
    type:
      - 'null'
      - string
    doc: Format of taxonomy file
    inputBinding:
      position: 101
      prefix: --taxonomy-format
  - id: xref_label
    type:
      - 'null'
      - string
    doc: Label to use when setting as xref
    inputBinding:
      position: 101
      prefix: --xref-label
outputs:
  - id: taxdump_out
    type:
      - 'null'
      - Directory
    doc: Path to output filtered backbone taxonomy
    outputBinding:
      glob: $(inputs.taxdump_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
