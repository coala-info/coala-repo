cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: multiqc_sav_multiqc
doc: "MultiQC aggregates results from bioinformatics analyses across many samples
  into a single report. It searches a given directory for analysis logs and compiles
  an HTML report. It's a general use tool, perfect for summarising the output from
  numerous bioinformatics tools. To run, supply with one or more directory to scan
  for analysis results. For example, to run in the current working directory, use
  'multiqc .'\n\nTool homepage: http://multiqc.info"
inputs:
  - id: analysis_directory
    type:
      - 'null'
      - Directory
    doc: Analysis directory to scan for results
    inputBinding:
      position: 1
  - id: ai
    type:
      - 'null'
      - boolean
    doc: Generate an AI summary of the report
    inputBinding:
      position: 102
      prefix: --ai
  - id: ai_custom_context_window
    type:
      - 'null'
      - int
    doc: Custom context window to use with OpenAI API
    default: 128000
    inputBinding:
      position: 102
      prefix: --ai-custom-context-window
  - id: ai_custom_endpoint
    type:
      - 'null'
      - string
    doc: Custom AI endpoint to use with OpenAI API
    inputBinding:
      position: 102
      prefix: --ai-custom-endpoint
  - id: ai_model
    type:
      - 'null'
      - string
    doc: Select AI model to use for report summarization
    inputBinding:
      position: 102
      prefix: --ai-model
  - id: ai_provider
    type:
      - 'null'
      - string
    doc: Select AI provider for report summarization.
    default: seqera
    inputBinding:
      position: 102
      prefix: --ai-provider
  - id: ai_summary
    type:
      - 'null'
      - boolean
    doc: Generate an AI summary of the report
    inputBinding:
      position: 102
      prefix: --ai-summary
  - id: ai_summary_full
    type:
      - 'null'
      - boolean
    doc: Generate a detailed AI summary of the report
    inputBinding:
      position: 102
      prefix: --ai-summary-full
  - id: check_config
    type:
      - 'null'
      - boolean
    doc: Check a MultiQC configuration file for errors and exit.
    inputBinding:
      position: 102
      prefix: --check-config
  - id: cl_config
    type:
      - 'null'
      - string
    doc: Specify MultiQC config YAML on the command line
    inputBinding:
      position: 102
      prefix: --cl-config
  - id: clean_up
    type:
      - 'null'
      - boolean
    doc: Remove the temporary directory and log file after finishing
    inputBinding:
      position: 102
      prefix: --clean-up
  - id: comment
    type:
      - 'null'
      - string
    doc: Custom comment, will be printed at the top of the report.
    inputBinding:
      position: 102
      prefix: --comment
  - id: config
    type:
      - 'null'
      - File
    doc: Specific config file to load, after those in MultiQC dir / home dir / 
      working dir.
    inputBinding:
      position: 102
      prefix: --config
  - id: custom_css_file
    type:
      - 'null'
      - File
    doc: Custom CSS file to add to the final report
    inputBinding:
      position: 102
      prefix: --custom-css-file
  - id: data_dir
    type:
      - 'null'
      - boolean
    doc: Force the parsed data directory to be created.
    inputBinding:
      position: 102
      prefix: --data-dir
  - id: data_format
    type:
      - 'null'
      - string
    doc: Output parsed data in a different format.
    inputBinding:
      position: 102
      prefix: --data-format
  - id: dev
    type:
      - 'null'
      - boolean
    doc: Development mode. Do not inline JS and CSS, export uncompressed plot 
      data
    inputBinding:
      position: 102
      prefix: --dev
  - id: development
    type:
      - 'null'
      - boolean
    doc: Development mode. Do not inline JS and CSS, export uncompressed plot 
      data
    inputBinding:
      position: 102
      prefix: --development
  - id: dirs
    type:
      - 'null'
      - boolean
    doc: Prepend directory to sample names
    inputBinding:
      position: 102
      prefix: --dirs
  - id: dirs_depth
    type:
      - 'null'
      - int
    doc: Prepend n directories to sample names. Negative number to take from 
      start of path.
    inputBinding:
      position: 102
      prefix: --dirs-depth
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Do not use this module. Can specify multiple times.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: export_plots
    type:
      - 'null'
      - boolean
    doc: Export plots as static images in addition to the report
    inputBinding:
      position: 102
      prefix: --export
  - id: file_list
    type:
      - 'null'
      - File
    doc: Supply a file containing a list of file paths to be searched, one per 
      row
    inputBinding:
      position: 102
      prefix: --file-list
  - id: filename
    type:
      - 'null'
      - string
    doc: Report filename. Use 'stdout' to print to standard out.
    inputBinding:
      position: 102
      prefix: --filename
  - id: flat_plots
    type:
      - 'null'
      - boolean
    doc: Use only flat plots (static images)
    inputBinding:
      position: 102
      prefix: --flat
  - id: fn_as_s_name
    type:
      - 'null'
      - boolean
    doc: Use the log filename as the sample name
    inputBinding:
      position: 102
      prefix: --fn_as_s_name
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing reports
    inputBinding:
      position: 102
      prefix: --force
  - id: fullnames
    type:
      - 'null'
      - boolean
    doc: Do not clean the sample names (leave as full file name)
    inputBinding:
      position: 102
      prefix: --fullnames
  - id: ignore
    type:
      - 'null'
      - string
    doc: Ignore analysis files
    inputBinding:
      position: 102
      prefix: --ignore
  - id: ignore_samples
    type:
      - 'null'
      - string
    doc: Ignore sample names
    inputBinding:
      position: 102
      prefix: --ignore-samples
  - id: ignore_symlinks
    type:
      - 'null'
      - boolean
    doc: Ignore symlinked directories and files
    inputBinding:
      position: 102
      prefix: --ignore-symlinks
  - id: interactive_plots
    type:
      - 'null'
      - boolean
    doc: Use only interactive plots (in-browser Javascript)
    inputBinding:
      position: 102
      prefix: --interactive
  - id: module
    type:
      - 'null'
      - type: array
        items: string
    doc: Use only this module. Can specify multiple times.
    inputBinding:
      position: 102
      prefix: --module
  - id: no_ai
    type:
      - 'null'
      - boolean
    doc: Disable AI toolbox and buttons in the report
    inputBinding:
      position: 102
      prefix: --no-ai
  - id: no_ansi
    type:
      - 'null'
      - boolean
    doc: Disable coloured log output
    inputBinding:
      position: 102
      prefix: --no-ansi
  - id: no_clean_up
    type:
      - 'null'
      - boolean
    doc: Do not remove the temporary directory and log file after finishing
    inputBinding:
      position: 102
      prefix: --no-clean-up
  - id: no_data_dir
    type:
      - 'null'
      - boolean
    doc: Do not force the parsed data directory to be created.
    inputBinding:
      position: 102
      prefix: --no-data-dir
  - id: no_megaqc_upload
    type:
      - 'null'
      - boolean
    doc: Don't upload generated report to MegaQC, even if MegaQC options are 
      found
    inputBinding:
      position: 102
      prefix: --no-megaqc-upload
  - id: no_report
    type:
      - 'null'
      - boolean
    doc: Do not generate a report, only export data and plots
    inputBinding:
      position: 102
      prefix: --no-report
  - id: no_version_check
    type:
      - 'null'
      - boolean
    doc: Disable checking the latest MultiQC version on the server
    inputBinding:
      position: 102
      prefix: --no-version-check
  - id: only_samples
    type:
      - 'null'
      - string
    doc: Only include sample names matching the given glob expression
    inputBinding:
      position: 102
      prefix: --only-samples
  - id: outdir
    type:
      - 'null'
      - string
    doc: Create report in the specified output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Creates PDF report with the 'simple' template. Requires Pandoc to be 
      installed.
    inputBinding:
      position: 102
      prefix: --pdf
  - id: profile_memory
    type:
      - 'null'
      - boolean
    doc: Add analysis of how much memory each module uses. Note that tracking 
      memory will increase the runtime, so the runtime metrics could scale up a 
      few times
    inputBinding:
      position: 102
      prefix: --profile-memory
  - id: profile_runtime
    type:
      - 'null'
      - boolean
    doc: Add analysis of how long MultiQC takes to run to the report
    inputBinding:
      position: 102
      prefix: --profile-runtime
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only show log warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: replace_names
    type:
      - 'null'
      - File
    doc: TSV file to rename sample names during report generation
    inputBinding:
      position: 102
      prefix: --replace-names
  - id: require_logs
    type:
      - 'null'
      - boolean
    doc: Require all explicitly requested modules to have log files. If not, 
      MultiQC will exit with an error.
    inputBinding:
      position: 102
      prefix: --require-logs
  - id: sample_filters
    type:
      - 'null'
      - File
    doc: TSV file containing show/hide patterns for the report
    inputBinding:
      position: 102
      prefix: --sample-filters
  - id: sample_names
    type:
      - 'null'
      - File
    doc: TSV file containing alternative sample names for renaming buttons in 
      the report
    inputBinding:
      position: 102
      prefix: --sample-names
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Don't catch exceptions, run additional code checks to help development.
    inputBinding:
      position: 102
      prefix: --strict
  - id: template
    type:
      - 'null'
      - string
    doc: Report template to use.
    default: default
    inputBinding:
      position: 102
      prefix: --template
  - id: title
    type:
      - 'null'
      - string
    doc: Report title. Printed as page header, used for filename if not 
      otherwise specified.
    inputBinding:
      position: 102
      prefix: --title
  - id: verbose
    type:
      - 'null'
      - int
    doc: Increase output verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zip_data_dir
    type:
      - 'null'
      - boolean
    doc: Compress the data directory.
    inputBinding:
      position: 102
      prefix: --zip-data-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc_sav:0.2.0--pyh7e72e81_0
stdout: multiqc_sav_multiqc.out
