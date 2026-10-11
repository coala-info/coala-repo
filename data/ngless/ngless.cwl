cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngless-wrapped
label: ngless
doc: "ngless implement the NGLess language\n\nTool homepage: http://ngless.embl.de"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.script_file) { l.push({"entry": inputs.script_file, "writable": true}); }
        (inputs.data_files || []).forEach(function (f) { l.push(f); });
        return l;
      }
inputs:
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files that the script reads by relative name (for example sample.fq); staged in the working directory
  - id: result_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of the files the script writes (the ofile values), collected as outputs
  - id: script_file
    type:
      - 'null'
      - File
    doc: Filename of script to interpret
    inputBinding:
      position: 1
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
      prefix: --check-deprecation
  - id: check_install
    type:
      - 'null'
      - boolean
    doc: Check if ngless is correctly installed
    inputBinding:
      position: 104
      prefix: --check-install
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
      prefix: --config-file
  - id: create_report
    type:
      - 'null'
      - boolean
    doc: create the report directory
    inputBinding:
      position: 104
      prefix: --create-report
  - id: debug
    type:
      - 'null'
      - string
    doc: Debug level
    inputBinding:
      position: 104
      prefix: --debug
  - id: download_demo
    type:
      - 'null'
      - string
    doc: Download a demo dataset by name
    inputBinding:
      position: 104
      prefix: --download-demo
  - id: download_file
    type:
      - 'null'
      - boolean
    doc: Download a file
    inputBinding:
      position: 104
      prefix: --download-file
  - id: download_url
    type:
      - 'null'
      - string
    doc: URL of the file to download
    inputBinding:
      position: 104
      prefix: --download-url
  - id: experimental_features
    type:
      - 'null'
      - boolean
    doc: Whether to allow the use of experimental features
    inputBinding:
      position: 104
      prefix: --experimental-features
  - id: export_cwl
    type:
      - 'null'
      - string
    doc: File to write CWL wrapper of given script
    inputBinding:
      position: 104
      prefix: --export-cwl
  - id: export_json
    type:
      - 'null'
      - string
    doc: File to write JSON representation of script to
    inputBinding:
      position: 104
      prefix: --export-json
  - id: html_report_directory
    type:
      - 'null'
      - string
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
      prefix: --index-path
  - id: install_reference_data
    type:
      - 'null'
      - string
    doc: Name of reference to install
    inputBinding:
      position: 104
      prefix: --install-reference-data
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: Whether to keep temporary files (default is delete them)
    inputBinding:
      position: 104
      prefix: --keep-temporary-files
  - id: local_file
    type:
      - 'null'
      - string
    doc: Local path to save the downloaded file
    inputBinding:
      position: 104
      prefix: --local-file
  - id: no_create_report
    type:
      - 'null'
      - boolean
    doc: opposite of --create-report
    inputBinding:
      position: 104
      prefix: --no-create-report
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not print copyright information
    inputBinding:
      position: 104
      prefix: --no-header
  - id: no_keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: opposite of --keep-temporary-files
    inputBinding:
      position: 104
      prefix: --no-keep-temporary-files
  - id: no_strict_threads
    type:
      - 'null'
      - boolean
    doc: opposite of --strict-threads
    inputBinding:
      position: 104
      prefix: --no-strict-threads
  - id: no_trace
    type:
      - 'null'
      - boolean
    doc: opposite of --trace
    inputBinding:
      position: 104
      prefix: --no-trace
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
      prefix: --print-path
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
      prefix: --search-dir
  - id: search_path
    type:
      - 'null'
      - Directory
    doc: Reference search directories (replace <references> in script)
    inputBinding:
      position: 104
      prefix: --search-path
  - id: strict_threads
    type:
      - 'null'
      - boolean
    doc: strictly respect the --threads option (by default, NGLess will, 
      occasionally, use more threads than specified)
    inputBinding:
      position: 104
      prefix: --strict-threads
  - id: subsample
    type:
      - 'null'
      - boolean
    doc: 'Subsample mode: quickly test a pipeline by discarding 99% of the input'
    inputBinding:
      position: 104
      prefix: --subsample
  - id: temporary_directory
    type:
      - 'null'
      - string
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
      prefix: --trace
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
  - id: result_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files written by the script (named in result_names)
    outputBinding:
      glob: $(inputs.result_names)
  - id: export_cwl_file
    type: ['null', File]
    doc: CWL wrapper of the script (with export_cwl)
    outputBinding:
      glob: $(inputs.export_cwl)
  - id: export_json_file
    type: ['null', File]
    doc: JSON representation of the script (with export_json)
    outputBinding:
      glob: $(inputs.export_json)
  - id: html_report_directory_dir
    type:
      - 'null'
      - Directory
    doc: name of output directory
    outputBinding:
      glob: $(inputs.html_report_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngless:1.5.0--h9ee0642_0
stdout: ngless.out
