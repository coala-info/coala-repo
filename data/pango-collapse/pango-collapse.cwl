cwlVersion: v1.2
class: CommandLineTool
baseCommand: pango-collapse
label: pango-collapse
doc: "Collapse Pango sublineages up to user defined parent lineages.\n\nTool homepage:
  https://github.com/MDU-PHL/pango-collapse"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Path to input CSV/TSV with Lineage column.
    inputBinding:
      position: 1
  - id: alias_file
    type:
      - 'null'
      - File
    doc: Path to Pango Alias file for pango_aliasor. Will download latest file if
      not supplied.
    inputBinding:
      position: 102
      prefix: --alias-file
  - id: collapse_column
    type:
      - 'null'
      - string
    doc: Column to use for the collapsed output.
    default: Lineage_family
    inputBinding:
      position: 102
      prefix: --collapse-column
  - id: collapse_file
    type:
      - 'null'
      - File
    doc: Path or URL to collapse file with parental lineages (one per line) to collapse
      up to. Defaults to collapse file shipped with this version of pango-collapse.
    inputBinding:
      position: 102
      prefix: --collapse-file
  - id: expand_column
    type:
      - 'null'
      - string
    doc: Column to use for the expanded output.
    default: Lineage_expanded
    inputBinding:
      position: 102
      prefix: --expand-column
  - id: full_column
    type:
      - 'null'
      - string
    doc: Column to use for the uncompressed output.
    default: Lineage_full
    inputBinding:
      position: 102
      prefix: --full-column
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Load the latest collapse from from 
      https://raw.githubusercontent.com/MDU-PHL/pango-collapse/main/pango_collapse/data/collapse.txt
    inputBinding:
      position: 102
      prefix: --latest
  - id: lineage_column
    type:
      - 'null'
      - string
    doc: Column to extract from input file for lineage.
    default: Lineage
    inputBinding:
      position: 102
      prefix: --lineage-column
  - id: parent
    type:
      - 'null'
      - type: array
        items: string
    doc: Parental lineage to collapse up to. Can be used multiple times to collapse
      to multiple lineages. If --collapse-file is supplied parents will be appended
      to the file.
    inputBinding:
      position: 102
      prefix: --parent
  - id: strict
    type:
      - 'null'
      - boolean
    doc: If a lineage is not in the collapse file return None instead of the compressed
      lineage.
    inputBinding:
      position: 102
      prefix: --strict
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Input file is in TSV format. If not supplied will try to infer from file
      extension.
    inputBinding:
      position: 102
      prefix: --tsv
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output CSV/TSV with Lineage column. If not supplied will print to
      stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pango-collapse:0.8.2--pyhdfd78af_0
