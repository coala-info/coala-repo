cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - export
  - v1
label: augur_export_v1
doc: "Export version 1 JSON schema (separate meta and tree JSONs) for visualization\
  \ with Auspice.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: tree
    type: File
    doc: 'tree to perform trait reconstruction on (default: None)'
    inputBinding:
      position: 1
      prefix: --tree
  - id: metadata
    type: File
    doc: 'sequence metadata (default: None)'
    inputBinding:
      position: 1
      prefix: --metadata
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'delimiters to accept when reading a metadata file. Only one delimiter will
      be inferred. (default: ('','', ''\t''))'
    inputBinding:
      position: 1
      prefix: --metadata-delimiters
  - id: node_data
    type:
      type: array
      items: File
    doc: 'JSON files with meta data for each node (default: None)'
    inputBinding:
      position: 1
      prefix: --node-data
  - id: output_tree
    type:
      - 'null'
      - string
    doc: 'JSON file name that is passed on to auspice (e.g., zika_tree.json). (default:
      None)'
    inputBinding:
      position: 1
      prefix: --output-tree
  - id: output_meta
    type:
      - 'null'
      - string
    doc: 'JSON file name that is passed on to auspice (e.g., zika_meta.json). (default:
      None)'
    inputBinding:
      position: 1
      prefix: --output-meta
  - id: auspice_config
    type:
      - 'null'
      - File
    doc: 'file with auspice configuration (default: None)'
    inputBinding:
      position: 1
      prefix: --auspice-config
  - id: colors
    type:
      - 'null'
      - File
    doc: 'Custom color definitions, one per line in the format `TRAIT_TYPE\tTRAIT_VALUE\tHEX_CODE`
      (default: None)'
    inputBinding:
      position: 1
      prefix: --colors
  - id: lat_longs
    type:
      - 'null'
      - File
    doc: 'file latitudes and longitudes, overrides built in mappings (default: None)'
    inputBinding:
      position: 1
      prefix: --lat-longs
  - id: tree_name
    type:
      - 'null'
      - string
    doc: 'Tree name (needed for tangle tree functionality) (default: False)'
    inputBinding:
      position: 1
      prefix: --tree-name
  - id: minify_json
    type:
      - 'null'
      - boolean
    doc: 'export JSONs without indentation or line returns (default: False)'
    inputBinding:
      position: 1
      prefix: --minify-json
  - id: output_sequence
    type:
      - 'null'
      - string
    doc: 'JSON file name that is passed on to auspice (e.g., zika_seq.json). (default:
      None)'
    inputBinding:
      position: 1
      prefix: --output-sequence
  - id: reference
    type:
      - 'null'
      - File
    doc: 'reference sequence for export to browser, only vcf (default: None)'
    inputBinding:
      position: 1
      prefix: --reference
  - id: reference_translations
    type:
      - 'null'
      - File
    doc: 'reference translations for export to browser, only vcf (default: None)'
    inputBinding:
      position: 1
      prefix: --reference-translations
outputs:
  - id: output_tree_file
    type:
      - 'null'
      - File
    doc: Auspice v1 tree JSON.
    outputBinding:
      glob: $(inputs.output_tree)
  - id: output_meta_file
    type:
      - 'null'
      - File
    doc: Auspice v1 meta JSON.
    outputBinding:
      glob: $(inputs.output_meta)
  - id: output_sequence_file
    type:
      - 'null'
      - File
    doc: Auspice v1 sequence JSON.
    outputBinding:
      glob: $(inputs.output_sequence)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
