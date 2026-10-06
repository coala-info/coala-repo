cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - export
  - v2
label: augur_export_v2
doc: "Export version 2 JSON schema for visualization with Auspice.\n\nTool homepage:\
  \ https://github.com/nextstrain/augur"
inputs:
  - id: tree
    type: File
    doc: 'Phylogenetic tree, usually output from `augur refine` (default: None)'
    inputBinding:
      position: 1
      prefix: --tree
  - id: output
    type: string
    doc: 'Output file (typically for visualisation in auspice) (default: None)'
    inputBinding:
      position: 1
      prefix: --output
  - id: auspice_config
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Auspice configuration file(s) (default: [])'
    inputBinding:
      position: 1
      prefix: --auspice-config
  - id: title
    type:
      - 'null'
      - string
    doc: 'Title to be displayed by auspice (default: None)'
    inputBinding:
      position: 1
      prefix: --title
  - id: maintainers
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Analysis maintained by, in format ''Name <URL>'' ''Name2 <URL>'', ... (default:
      None)'
    inputBinding:
      position: 1
      prefix: --maintainers
  - id: build_url
    type:
      - 'null'
      - string
    doc: 'Build URL/repository to be displayed by Auspice (default: None)'
    inputBinding:
      position: 1
      prefix: --build-url
  - id: description
    type:
      - 'null'
      - File
    doc: 'Markdown file with description of build and/or acknowledgements to be displayed
      by Auspice (default: None)'
    inputBinding:
      position: 1
      prefix: --description
  - id: warning
    type:
      - 'null'
      - string
    doc: 'Text or file in Markdown format to be displayed as a warning banner by Auspice
      (default: None)'
    inputBinding:
      position: 1
      prefix: --warning
  - id: geo_resolutions
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Geographic traits to be displayed on map (default: None)'
    inputBinding:
      position: 1
      prefix: --geo-resolutions
  - id: color_by_metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Metadata columns to include as coloring options. Ignores columns named ''none'',
      so please rename them if you would like to include them as colorings. (default:
      None)'
    inputBinding:
      position: 1
      prefix: --color-by-metadata
  - id: metadata_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Metadata columns to export in addition to columns provided by --color-by-metadata
      or colorings in the Auspice configuration file. These columns will not be used
      as coloring options in Auspice but will be visible in the tree. Ignores columns
      named ''none'', so please rename them if you would like to include them as metadata
      fields. (default: None)'
    inputBinding:
      position: 1
      prefix: --metadata-columns
  - id: panels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Restrict panel display in auspice. Options are tree, map, entropy, frequencies,
      measurements. Ignore this option to display all available panels. (default:
      None)'
    inputBinding:
      position: 1
      prefix: --panels
  - id: node_data
    type:
      - 'null'
      - type: array
        items: File
    doc: 'JSON files containing metadata for nodes in the tree. Keys are automatically
      exported as colorings unless special-cased. URLs for a key ''X'' can be stored
      under key ''X__url'' and will be automatically exported. (default: None)'
    inputBinding:
      position: 1
      prefix: --node-data
  - id: metadata
    type:
      - 'null'
      - File
    doc: 'Additional metadata for strains in the tree. Columns are not typically exported
      by default and must be specified via arguments or within the config JSON. URLs
      for a column ''X'' can be stored in column ''X__url'' and will be automatically
      exported. (default: None)'
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
  - id: metadata_id_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'names of possible metadata columns containing identifier information, ordered
      by priority. Only one ID column will be inferred. (default: (''strain'', ''name''))'
    inputBinding:
      position: 1
      prefix: --metadata-id-columns
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
    doc: 'Latitudes and longitudes for geography traits. See this file for the format:
      <https://github.com/nextstra in/augur/blob/33.0.0/augur/data/lat_longs.tsv>.
      This file provides the default set of latitudes and longitudes. An additional
      file specified by this option will extend the default set. Duplicates based
      on the first two columns will be resolved by taking the coordinates from the
      user-provided file. (default: None)'
    inputBinding:
      position: 1
      prefix: --lat-longs
  - id: minify_json
    type:
      - 'null'
      - boolean
    doc: Always export JSONs without indentation or line returns. A truthy value (e.g.
      1) in :envvar:`AUGUR_MINIFY_JSON` has the same effect, but it can be overridden
      by ``--no-minify-json``.
    inputBinding:
      position: 1
      prefix: --minify-json
  - id: no_minify_json
    type:
      - 'null'
      - boolean
    doc: Always export JSONs to be human readable. This overrides :envvar:`AUGUR_MINIFY_JSON`.
    inputBinding:
      position: 1
      prefix: --no-minify-json
  - id: include_root_sequence
    type:
      - 'null'
      - boolean
    doc: 'Export as an additional JSON. The filename will follow the pattern of <OUTPUT>_root-sequence.json
      for a main auspice JSON of <OUTPUT>.json (default: False)'
    inputBinding:
      position: 1
      prefix: --include-root-sequence
  - id: include_root_sequence_inline
    type:
      - 'null'
      - boolean
    doc: 'Export the root sequence within the dataset JSON. This should only be used
      for small genomes for file size reasons. (default: False)'
    inputBinding:
      position: 1
      prefix: --include-root-sequence-inline
  - id: validation_mode
    type:
      - 'null'
      - type: enum
        symbols:
          - error
          - warn
          - skip
    doc: 'Control if optional validation checks are performed and what happens if
      they fail. ''error'' and ''warn'' modes perform validation and emit messages
      about failed validation checks. ''error'' mode causes a non- zero exit status
      if any validation checks failed, while ''warn'' does not. ''skip'' mode performs
      no validation. Note that some validation checks are non- optional and as such
      are not affected by this setting. (default: error)'
    inputBinding:
      position: 1
      prefix: --validation-mode
  - id: skip_validation
    type:
      - 'null'
      - boolean
    doc: 'Skip validation of input/output files, equivalent to --validation-mode=skip.
      Use at your own risk! (default: None)'
    inputBinding:
      position: 1
      prefix: --skip-validation
  - id: output_auspice_config
    type:
      - 'null'
      - string
    doc: 'Write out the merged auspice configuration file for debugging purposes etc.
      File is only written if you provide multiple config files via --auspice-config.
      (default: None)'
    inputBinding:
      position: 1
      prefix: --output-auspice-config
outputs:
  - id: output_file
    type: File
    doc: Auspice v2 dataset JSON.
    outputBinding:
      glob: $(inputs.output)
  - id: output_auspice_config_file
    type:
      - 'null'
      - File
    doc: Merged auspice configuration file.
    outputBinding:
      glob: $(inputs.output_auspice_config)
  - id: sidecar_jsons
    type:
      type: array
      items: File
    doc: Sidecar JSONs written next to the main JSON (e.g. <OUTPUT>_root-sequence.json).
    outputBinding:
      glob: $(inputs.output.replace(/\.json$/, ''))_*.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
