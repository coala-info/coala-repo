cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_query
doc: "Query the index for samples and summarize their mutations or MLST features.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: query
inputs:
  - id: project_dir
    type: Directory
    doc: "project folder made by gdi init (global option --project-dir)"
    inputBinding:
      position: 1
      prefix: --project-dir
      valueFrom: $(self.basename)
  - id: ncores
    type:
      - 'null'
      - int
    doc: "Number of cores for any parallel processing"
    inputBinding:
      position: 1
      prefix: --ncores
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Sets the log level (TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 1
      prefix: --log-level
  - id: reference_name
    type:
      - 'null'
      - string
    doc: "Reference genome name for querying by phylogenetic distance"
    inputBinding:
      position: 10
      prefix: --reference-name
  - id: summary
    type:
      - 'null'
      - boolean
    doc: "Print summary information on the query"
    inputBinding:
      position: 11
      prefix: --summary
  - id: no_summary
    type:
      - 'null'
      - boolean
    doc: "Do not print a summary (default)"
    inputBinding:
      position: 12
      prefix: --no-summary
  - id: features_summary
    type:
      - 'null'
      - string
    doc: "Summarize by the passed feature: mutations or mlst"
    inputBinding:
      position: 13
      prefix: --features-summary
  - id: features_summary_unique
    type:
      - 'null'
      - string
    doc: "Summarize by the passed feature, unique features only: mutations or mlst"
    inputBinding:
      position: 14
      prefix: --features-summary-unique
  - id: include_annotations
    type:
      - 'null'
      - boolean
    doc: "Include variant annotations in the feature summary (default)"
    inputBinding:
      position: 15
      prefix: --include-annotations
  - id: no_include_annotations
    type:
      - 'null'
      - boolean
    doc: "Leave out variant annotations in the feature summary"
    inputBinding:
      position: 16
      prefix: --no-include-annotations
  - id: query_command
    type:
      - 'null'
      - type: array
        items: string
    doc: "Query expression words, for example: hasa:reference:5061:G:C"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entry": inputs.project_dir, "writable": true}];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_query.out
