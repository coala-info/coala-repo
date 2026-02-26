cwlVersion: v1.2
class: CommandLineTool
baseCommand: ov report
label: oakvar_ov report
doc: "Generate reports from a job\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: dbpath
    type: string
    doc: Path to aggregator output
    inputBinding:
      position: 1
  - id: cols
    type:
      - 'null'
      - type: array
        items: string
    doc: columns to include in reports
    inputBinding:
      position: 102
      prefix: --cols
  - id: conf_path
    type:
      - 'null'
      - File
    doc: path to a conf file
    inputBinding:
      position: 102
      prefix: -c
  - id: exclude_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample IDs to exclude
    inputBinding:
      position: 102
      prefix: --excludesample
  - id: filter_name
    type:
      - 'null'
      - string
    doc: Name of filter (stored in aggregator output)
    inputBinding:
      position: 102
      prefix: -F
  - id: filter_path
    type:
      - 'null'
      - File
    doc: Path to filter file
    inputBinding:
      position: 102
      prefix: -f
  - id: filter_sql
    type:
      - 'null'
      - string
    doc: Filter SQL
    inputBinding:
      position: 102
      prefix: --filtersql
  - id: head_n
    type:
      - 'null'
      - int
    doc: Make reports with the first n number of variants.
    inputBinding:
      position: 102
      prefix: --head
  - id: include_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample IDs to include
    inputBinding:
      position: 102
      prefix: --includesample
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Original input file path
    inputBinding:
      position: 102
      prefix: --inputfiles
  - id: level
    type:
      - 'null'
      - string
    doc: Level to make a report for. 'all' to include all levels. Other possible
      levels include 'variant' and 'gene'.
    inputBinding:
      position: 102
      prefix: --level
  - id: log_to_file
    type:
      - 'null'
      - boolean
    doc: Use this option to prevent gene level result from being added to 
      variant level result.
    inputBinding:
      position: 102
      prefix: --logtofile
  - id: module_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Module-specific option in module_name.key=value syntax. For example, 
      --module-options vcfreporter.type=separate
    inputBinding:
      position: 102
      prefix: --module-options
  - id: no_gene_level_on_variant_level
    type:
      - 'null'
      - boolean
    doc: Use this option to prevent gene level result from being added to 
      variant level result.
    inputBinding:
      position: 102
      prefix: --nogenelevelonvariantlevel
  - id: no_summary
    type:
      - 'null'
      - boolean
    doc: Skip gene level summarization. This saves time.
    inputBinding:
      position: 102
      prefix: --no-summary
  - id: package
    type:
      - 'null'
      - string
    doc: Use filters and report types in a package
    inputBinding:
      position: 102
      prefix: --package
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output to STDOUT
    inputBinding:
      position: 102
      prefix: --quiet
  - id: report_types
    type:
      - 'null'
      - type: array
        items: string
    doc: report types
    inputBinding:
      position: 102
      prefix: -t
  - id: reporter_paths
    type:
      - 'null'
      - type: array
        items: string
    doc: report module name
    inputBinding:
      position: 102
      prefix: --reporter-paths
  - id: save_path
    type:
      - 'null'
      - File
    doc: Path to save file
    inputBinding:
      position: 102
      prefix: -s
  - id: separate_sample
    type:
      - 'null'
      - boolean
    doc: Write each variant-sample pair on a separate line
    inputBinding:
      position: 102
      prefix: --separatesample
  - id: user
    type:
      - 'null'
      - string
    doc: User who is creating this report. Default is default.
    default: default
    inputBinding:
      position: 102
      prefix: --user
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: directory for output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
