cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/import_classification_data.R
label: atlas-data-import_import_classification_data.R
doc: "Imports classifiers for specified dataset accession codes, tools, or species.\n\
  \nTool homepage: https://github.com/ebi-gene-expression-group/atlas-data-import"
inputs:
  - id: accession_code
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more dataset accession codes of the data set for which to 
      download the classifiers. By default, all classifiers are downloaded for a
      given dataset.
    inputBinding:
      position: 101
      prefix: --accession-code
  - id: classifiers_output_dir
    type:
      - 'null'
      - boolean
    doc: Path for directory storing imported classifiers
    inputBinding:
      position: 101
      prefix: --classifiers-output-dir
  - id: classifiers_prefix
    type:
      - 'null'
      - string
    doc: URL prefix for imported classifiers.
    inputBinding:
      position: 101
      prefix: --classifiers-prefix
  - id: condensed_sdrf
    type:
      - 'null'
      - boolean
    doc: If --get-sdrf is set to TRUE, import condensed SDRF? By default, a 
      normal version is imported.
    inputBinding:
      position: 101
      prefix: --condensed-sdrf
  - id: experiments_prefix
    type:
      - 'null'
      - string
    doc: URL prefix for imported experiment data.
    inputBinding:
      position: 101
      prefix: --experiments-prefix
  - id: get_sdrf
    type:
      - 'null'
      - boolean
    doc: Should SDRF file(s) be downloaded?
    inputBinding:
      position: 101
      prefix: --get-sdrf
  - id: get_tool_perf_table
    type:
      - 'null'
      - boolean
    doc: Should the tool performance table be imported?
    inputBinding:
      position: 101
      prefix: --get-tool-perf-table
  - id: sdrf_output_dir
    type:
      - 'null'
      - Directory
    doc: Output path for imported SDRF files directory
    inputBinding:
      position: 101
      prefix: --sdrf-output-dir
  - id: species
    type:
      - 'null'
      - string
    doc: Which species' classifiers should be imported?
    inputBinding:
      position: 101
      prefix: --species
  - id: tool
    type:
      - 'null'
      - string
    doc: Which tool's classifiers should be imported?
    inputBinding:
      position: 101
      prefix: --tool
  - id: tool_perf_table_url
    type:
      - 'null'
      - string
    doc: URL for import of tool performance table
    inputBinding:
      position: 101
      prefix: --tool-perf-table-url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-data-import:0.1.1--hdfd78af_0
stdout: atlas-data-import_import_classification_data.R.out
