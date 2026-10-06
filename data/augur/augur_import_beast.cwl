cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - import
  - beast
label: augur_import_beast
doc: "Import beast analysis.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: mcc
    type: File
    doc: 'BEAST MCC tree (default: None)'
    inputBinding:
      position: 1
      prefix: --mcc
  - id: most_recent_tip_date
    type:
      - 'null'
      - float
    doc: 'Numeric date of most recent tip in tree (--tip-date- regex, --tip-date-format
      and --tip-date-delimeter are ignored if this is set) (default: 0)'
    inputBinding:
      position: 1
      prefix: --most-recent-tip-date
  - id: tip_date_regex
    type:
      - 'null'
      - string
    doc: 'regex to extract dates from tip names (default: [0-9]{4}(\-[0-9]{2})*(\-[0-9]{2})*$)'
    inputBinding:
      position: 1
      prefix: --tip-date-regex
  - id: tip_date_format
    type:
      - 'null'
      - string
    doc: 'Format of date (if extracted by regex) (default: %Y-%m-%d)'
    inputBinding:
      position: 1
      prefix: --tip-date-format
  - id: tip_date_delimeter
    type:
      - 'null'
      - string
    doc: 'delimeter used in tip-date-format. Used to match partial dates. (default:
      -)'
    inputBinding:
      position: 1
      prefix: --tip-date-delimeter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Display verbose output. Only useful for debugging. (default: False)'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: recursion_limit
    type:
      - 'null'
      - int
    doc: 'Set a custom recursion limit (dangerous!) (default: False)'
    inputBinding:
      position: 1
      prefix: --recursion-limit
  - id: output_tree
    type: string
    doc: 'file name to write tree to (default: None)'
    inputBinding:
      position: 1
      prefix: --output-tree
  - id: output_node_data
    type: string
    doc: 'file name to write (temporal) branch lengths & BEAST traits as node data
      (default: None)'
    inputBinding:
      position: 1
      prefix: --output-node-data
outputs:
  - id: output_tree_file
    type: File
    doc: Newick tree with branch lengths in time units.
    outputBinding:
      glob: $(inputs.output_tree)
  - id: output_node_data_file
    type: File
    doc: Node data JSON with (temporal) branch lengths and BEAST traits.
    outputBinding:
      glob: $(inputs.output_node_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
