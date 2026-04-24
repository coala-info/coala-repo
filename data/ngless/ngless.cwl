cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngless-wrapped
label: ngless
doc: "ngless implement the NGLess language\n\nTool homepage: http://ngless.embl.de"
inputs:
  - id: script_file
    type:
      - 'null'
      - File
    doc: Filename of script to interpret
    inputBinding:
      position: 1
  - id: reference_data
    type:
      - 'null'
      - string
    doc: Name of reference to install
    inputBinding:
      position: 2
  - id: additional_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the script
    inputBinding:
      position: 3
  - id: check_deprecation
    type:
      - 'null'
      - boolean
    doc: Check if ngless version or any used modules have been deprecated
    inputBinding:
      position: 104
  - id: check_install
    type:
      - 'null'
      - boolean
    doc: Check if ngless is correctly installed
    inputBinding:
      position: 104
  - id: color
    type:
      - 'null'
      - string
    doc: Color settings, one of 'auto' (color if writing to a terminal, this is 
      the default), 'force' (always color), 'no' (no color).
    inputBinding:
      position: 104
      prefix: --color
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration files to parse
    inputBinding:
      position: 104
  - id: create_report
    type:
      - 'null'
      - boolean
    doc: create the report directory
    inputBinding:
      position: 104
  - id: debug
    type:
      - 'null'
      - string
    doc: Debug level
    inputBinding:
      position: 104
  - id: download_demo
    type:
      - 'null'
      - string
    doc: Download a demo dataset by name
    inputBinding:
      position: 104
  - id: download_file
    type:
      - 'null'
      - boolean
    doc: Download a file
    inputBinding:
      position: 104
  - id: download_url
    type:
      - 'null'
      - string
    doc: URL of the file to download
    inputBinding:
      position: 104
  - id: experimental_features
    type:
      - 'null'
      - boolean
    doc: Whether to allow the use of experimental features
    inputBinding:
      position: 104
  - id: export_cwl
    type:
      - 'null'
      - File
    doc: File to write CWL wrapper of given script
    inputBinding:
      position: 104
  - id: export_json
    type:
      - 'null'
      - File
    doc: File to write JSON representation of script to
    inputBinding:
      position: 104
  - id: html_report_directory
    type:
      - 'null'
      - Directory
    doc: name of output directory
    inputBinding:
      position: 104
      prefix: --html-report-directory
  - id: index_path
    type:
      - 'null'
      - Directory
    doc: Index path (directory where indices are stored)
    inputBinding:
      position: 104
  - id: install_reference_data
    type:
      - 'null'
      - boolean
    doc: Install reference data
    inputBinding:
      position: 104
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: Whether to keep temporary files (default is delete them)
    inputBinding:
      position: 104
  - id: local_file
    type:
      - 'null'
      - File
    doc: Local path to save the downloaded file
    inputBinding:
      position: 104
  - id: no_create_report
    type:
      - 'null'
      - boolean
    doc: opposite of --create-report
    inputBinding:
      position: 104
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not print copyright information
    inputBinding:
      position: 104
  - id: no_keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: opposite of --keep-temporary-files
    inputBinding:
      position: 104
  - id: no_strict_threads
    type:
      - 'null'
      - boolean
    doc: opposite of --strict-threads
    inputBinding:
      position: 104
  - id: no_trace
    type:
      - 'null'
      - boolean
    doc: opposite of --trace
    inputBinding:
      position: 104
  - id: print_last
    type:
      - 'null'
      - boolean
    doc: print value of last line in script
    inputBinding:
      position: 104
      prefix: --print-last
  - id: print_path
    type:
      - 'null'
      - string
    doc: Print the path of an executable
    inputBinding:
      position: 104
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output
    inputBinding:
      position: 104
      prefix: --quiet
  - id: script_inline
    type:
      - 'null'
      - string
    doc: inline script to execute
    inputBinding:
      position: 104
      prefix: --script
  - id: search_dir
    type:
      - 'null'
      - Directory
    doc: Deprecated. Use --search-path instead
    inputBinding:
      position: 104
  - id: search_path
    type:
      - 'null'
      - Directory
    doc: Reference search directories (replace <references> in script)
    inputBinding:
      position: 104
  - id: strict_threads
    type:
      - 'null'
      - boolean
    doc: strictly respect the --threads option (by default, NGLess will, 
      occasionally, use more threads than specified)
    inputBinding:
      position: 104
  - id: subsample
    type:
      - 'null'
      - boolean
    doc: 'Subsample mode: quickly test a pipeline by discarding 99% of the input'
    inputBinding:
      position: 104
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Directory where to store temporary files
    inputBinding:
      position: 104
      prefix: --temporary-directory
  - id: threads
    type:
      - 'null'
      - int
    doc: Nr of threads to use
    inputBinding:
      position: 104
      prefix: --jobs
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Set highest verbosity mode
    inputBinding:
      position: 104
  - id: validate_only
    type:
      - 'null'
      - boolean
    doc: Only validate input, do not run script
    inputBinding:
      position: 104
      prefix: --validate-only
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print paths
    inputBinding:
      position: 104
      prefix: --verbose
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngless:1.5.0--h9ee0642_0
stdout: ngless.out
