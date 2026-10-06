cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - measurements
  - export
label: augur_measurements_export
doc: "Export a measurements JSON for a single collection.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: collection
    type: File
    doc: 'Collection of measurements and metadata in a TSV file. Keep in mind duplicate
      columns will be renamed as ''X'', ''X.1'', ''X.2''...''X.N'' (default: None)'
    inputBinding:
      position: 1
      prefix: --collection
  - id: strain_column
    type:
      - 'null'
      - string
    doc: 'Name of the column containing strain names. Provided column will be renamed
      to `strain` so please make sure no other columns are named `strain`. Strain
      names in this column should match the strain names in the corresponding Auspice
      dataset JSON. (default: strain)'
    inputBinding:
      position: 1
      prefix: --strain-column
  - id: value_column
    type:
      - 'null'
      - string
    doc: 'Name of the column containing the numeric values to be plotted for the given
      collection. Provided column will be renamed to `value` so please make sure no
      other columns are named `value`. (default: value)'
    inputBinding:
      position: 1
      prefix: --value-column
  - id: output_json
    type: string
    doc: 'Output JSON file. The file name must follow the Auspice sidecar file naming
      convention to be recognized as a sidecar file. See Nextstrain data format docs
      for more details. (default: None)'
    inputBinding:
      position: 1
      prefix: --output-json
  - id: collection_config
    type:
      - 'null'
      - File
    doc: 'Collection configuration file for advanced configurations. (default: None)'
    inputBinding:
      position: 1
      prefix: --collection-config
  - id: grouping_column
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Name of the column(s) that should be used as grouping(s) for measurements.
      Note that if groupings are provided via command line args, the default group-
      by field in the config JSON will be dropped. (default: None)'
    inputBinding:
      position: 1
      prefix: --grouping-column
  - id: key
    type:
      - 'null'
      - string
    doc: 'A short key name of the collection for internal use within Auspice. If not
      provided via config or command line option, the collection TSV filename will
      be used. (default: None)'
    inputBinding:
      position: 1
      prefix: --key
  - id: title
    type:
      - 'null'
      - string
    doc: 'The full title of the collection to display in the measurements panel title.
      If not provided via config or command line option, the panel''s default title
      is ''Measurements''. (default: None)'
    inputBinding:
      position: 1
      prefix: --title
  - id: x_axis_label
    type:
      - 'null'
      - string
    doc: 'The short label to display for the x-axis that describles the value of the
      measurements. If not provided via config or command line option, the panel''s
      default x-axis label is ''measurement values''. (default: None)'
    inputBinding:
      position: 1
      prefix: --x-axis-label
  - id: thresholds
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Measurements value threshold(s) to be displayed in the measurements panel.
      (default: None)'
    inputBinding:
      position: 1
      prefix: --thresholds
  - id: filters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The columns that are to be used a filters for measurements. If not provided,
      all columns will be available as filters. (default: None)'
    inputBinding:
      position: 1
      prefix: --filters
  - id: group_by
    type:
      - 'null'
      - string
    doc: 'The default grouping column. If not provided, the first grouping will be
      used. (default: None)'
    inputBinding:
      position: 1
      prefix: --group-by
  - id: measurements_display
    type:
      - 'null'
      - type: enum
        symbols:
          - raw
          - mean
    doc: 'The default display of the measurements (default: None)'
    inputBinding:
      position: 1
      prefix: --measurements-display
  - id: show_overall_mean
    type:
      - 'null'
      - boolean
    doc: 'Show or hide the overall mean per group by default (default: None)'
    inputBinding:
      position: 1
      prefix: --show-overall-mean
  - id: hide_overall_mean
    type:
      - 'null'
      - boolean
    doc: 'Show or hide the overall mean per group by default (default: None)'
    inputBinding:
      position: 1
      prefix: --hide-overall-mean
  - id: show_threshold
    type:
      - 'null'
      - boolean
    doc: 'Show or hide the threshold(s) by default. This will be ignored if no threshold(s)
      are provided. (default: None)'
    inputBinding:
      position: 1
      prefix: --show-threshold
  - id: hide_threshold
    type:
      - 'null'
      - boolean
    doc: 'Show or hide the threshold(s) by default. This will be ignored if no threshold(s)
      are provided. (default: None)'
    inputBinding:
      position: 1
      prefix: --hide-threshold
  - id: include_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The columns to include from the collection TSV in the measurements JSON.
      Be sure to list columns that are used as groupings and/or filters. If no columns
      are provided, then all columns will be included by default. (default: None)'
    inputBinding:
      position: 1
      prefix: --include-columns
  - id: minify_json
    type:
      - 'null'
      - boolean
    doc: 'Export JSON without indentation or line returns. (default: False)'
    inputBinding:
      position: 1
      prefix: --minify-json
outputs:
  - id: output_json_file
    type: File
    doc: Measurements sidecar JSON for Auspice.
    outputBinding:
      glob: $(inputs.output_json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
