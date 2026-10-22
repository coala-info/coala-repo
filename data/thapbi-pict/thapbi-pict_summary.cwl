cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - summary
label: thapbi-pict_summary
doc: "Sample and sequence summary reports on classifier output.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Sample tally file `*.tally.tsv` and matching classifier output file `*.method.tsv`."
    inputBinding:
      position: 101
      prefix: -i
  - id: ignore_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more filename prefixes to ignore, default Undetermined_ unknown_"
    inputBinding:
      position: 101
      prefix: --ignore-prefixes
  - id: output
    type: string
    doc: "Output filename stem for generating reports. Not a directory."
    inputBinding:
      position: 101
      prefix: -o
  - id: method
    type:
      - 'null'
      - string
    doc: "Classifier method(s) to report, comma separated list, default is 'onebp' (only)."
    inputBinding:
      position: 101
      prefix: -m
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum sample level abundance to require for the report. Default 100."
    inputBinding:
      position: 101
      prefix: -a
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Optional tab separated table containing metadata indexed by sample name. Must also specify the columns with -c."
    inputBinding:
      position: 101
      prefix: -t
  - id: metaencoding
    type:
      - 'null'
      - string
    doc: "Optional encoding of the metadata table, e.g. 'UTF-8', 'latin1'."
    inputBinding:
      position: 101
      prefix: -e
  - id: metacols
    type:
      - 'null'
      - string
    doc: "Comma separated list (e.g, '1,3,5') of columns from the metadata table to be included in the report header."
    inputBinding:
      position: 101
      prefix: -c
  - id: metaindex
    type:
      - 'null'
      - string
    doc: "If using metadata, which column contains the sequenced sample names. Default 1."
    inputBinding:
      position: 101
      prefix: -x
  - id: metagroups
    type:
      - 'null'
      - string
    doc: "If using metadata, which column values should be used for applying background color bands."
    inputBinding:
      position: 101
      prefix: -g
  - id: metafields
    type:
      - 'null'
      - int
    doc: "If using metadata, which row should be used as the field names? Default 1, use 0 for no labels."
    inputBinding:
      position: 101
      prefix: --metafields
  - id: requiremeta
    type:
      - 'null'
      - boolean
    doc: "Ignore any input files without metadata for report."
    inputBinding:
      position: 101
      prefix: -q
  - id: unsequenced
    type:
      - 'null'
      - boolean
    doc: "Show unsequenced metadata entries in sample report."
    inputBinding:
      position: 101
      prefix: -u
  - id: biom
    type:
      - 'null'
      - boolean
    doc: "Enable optional BIOM output."
    inputBinding:
      position: 101
      prefix: -b
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: reports
    type:
      type: array
      items: File
    doc: "Read and sample tables (TSV and Excel) written with the output stem"
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
