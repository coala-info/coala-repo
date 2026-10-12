cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oc
  - report
label: open-cravat_report
doc: "Generate a report from an Open-CRAVAT result database.\n\nTool homepage: http://www.opencravat.org"
inputs:
  - id: dbpath
    type: File
    doc: "Path to aggregator output (sqlite result database)."
    inputBinding:
      position: 1
  - id: report_types
    type:
      - 'null'
      - string[]
    doc: "Report types."
    inputBinding:
      position: 101
      prefix: "-t"
  - id: filterpath
    type:
      - 'null'
      - File
    doc: "Path to filter file."
    inputBinding:
      position: 101
      prefix: "-f"
  - id: filtersql
    type:
      - 'null'
      - string
    doc: "Filter SQL."
    inputBinding:
      position: 101
      prefix: "--filtersql"
  - id: filtername
    type:
      - 'null'
      - string
    doc: "Name of filter (stored in aggregator output)."
    inputBinding:
      position: 101
      prefix: "-F"
  - id: savepath
    type:
      - 'null'
      - string
    doc: "Path to save file (report name prefix)."
    inputBinding:
      position: 101
      prefix: "-s"
  - id: confpath
    type:
      - 'null'
      - File
    doc: "Path to a conf file."
    inputBinding:
      position: 101
      prefix: "-c"
  - id: module_name
    type:
      - 'null'
      - string
    doc: "Report module name."
    inputBinding:
      position: 101
      prefix: "--module-name"
  - id: nogenelevelonvariantlevel
    type:
      - 'null'
      - boolean
    doc: "Prevent gene level result from being added to variant level result."
    inputBinding:
      position: 101
      prefix: "--nogenelevelonvariantlevel"
  - id: confs
    type:
      - 'null'
      - string
    doc: "Configuration string."
    inputBinding:
      position: 101
      prefix: "--confs"
  - id: inputfiles
    type:
      - 'null'
      - string[]
    doc: "Original input file path."
    inputBinding:
      position: 101
      prefix: "--inputfiles"
  - id: separatesample
    type:
      - 'null'
      - boolean
    doc: "Write each variant-sample pair on a separate line."
    inputBinding:
      position: 101
      prefix: "--separatesample"
  - id: output_dir_name
    type: string
    doc: "Directory for output files."
    inputBinding:
      position: 101
      prefix: "-d"
  - id: do_not_change_status
    type:
      - 'null'
      - boolean
    doc: "Job status in status.json will not be changed."
    inputBinding:
      position: 101
      prefix: "--do-not-change-status"
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Suppress output to STDOUT."
    inputBinding:
      position: 101
      prefix: "--silent"
  - id: system_option
    type:
      - 'null'
      - string[]
    doc: "System option in key=value syntax. Default turns off usage metrics upload, which needs a writable install folder."
    default: ["save_metrics=false"]
    inputBinding:
      position: 101
      prefix: "--system-option"
  - id: module_option
    type:
      - 'null'
      - string[]
    doc: "Module-specific option in module_name.key=value syntax."
    inputBinding:
      position: 101
      prefix: "--module-option"
  - id: concise_report
    type:
      - 'null'
      - boolean
    doc: "Generate concise report with default columns defined by annotation modules."
    inputBinding:
      position: 101
      prefix: "--concise-report"
  - id: includesample
    type:
      - 'null'
      - string[]
    doc: "Sample IDs to include."
    inputBinding:
      position: 101
      prefix: "--includesample"
  - id: excludesample
    type:
      - 'null'
      - string[]
    doc: "Sample IDs to exclude."
    inputBinding:
      position: 101
      prefix: "--excludesample"
  - id: package
    type:
      - 'null'
      - string
    doc: "Use filters and report types in a package."
    inputBinding:
      position: 101
      prefix: "--package"
  - id: md
    type:
      - 'null'
      - string
    doc: "Root directory of OpenCRAVAT modules (annotators, etc)."
    inputBinding:
      position: 101
      prefix: "--md"
outputs:
  - id: report_files
    type: File[]
    doc: "Report files"
    outputBinding:
      glob: $(inputs.output_dir_name)/*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbpath)
        writable: true
      - entryname: $(inputs.output_dir_name)
        entry: "$({class: 'Directory', listing: [{class: 'File', basename: '.keep', contents: ''}]})"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
