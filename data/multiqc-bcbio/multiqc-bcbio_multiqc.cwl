cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: multiqc-bcbio_multiqc
doc: "Main MultiQC run command for use with the click command line, complete with
  all click function decorators. To make it easy to use MultiQC within notebooks and
  other locations that don't need click, we simply pass the parsed variables on to
  a vanilla python function.\n\nTool homepage: http://multiqc.info"
inputs:
  - id: analysis_directory
    type: Directory
    doc: analysis directory
    inputBinding:
      position: 1
  - id: cl_config
    type:
      - 'null'
      - string
    doc: Specify MultiQC config YAML on the command line
    inputBinding:
      position: 102
      prefix: --cl-config
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
    doc: 'Output parsed data in a different format. Default: tsv'
    default: tsv
    inputBinding:
      position: 102
      prefix: --data-format
  - id: dirs_depth
    type:
      - 'null'
      - int
    doc: Prepend [INT] directories to sample names. Negative number to take from
      start of path.
    inputBinding:
      position: 102
      prefix: --dirs-depth
  - id: exclude_module
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
      - boolean
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
    doc: Ignore analysis files (glob expression)
    inputBinding:
      position: 102
      prefix: --ignore
  - id: ignore_samples
    type:
      - 'null'
      - string
    doc: Ignore sample names (glob expression)
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
    doc: Use only interactive plots (HighCharts Javascript)
    inputBinding:
      position: 102
      prefix: --interactive
  - id: lint
    type:
      - 'null'
      - boolean
    doc: Use strict linting (validation) to help code development
    inputBinding:
      position: 102
      prefix: --lint
  - id: module
    type:
      - 'null'
      - type: array
        items: string
    doc: Use only this module. Can specify multiple times.
    inputBinding:
      position: 102
      prefix: --module
  - id: no_ansi
    type:
      - 'null'
      - boolean
    doc: Disable coloured log output
    inputBinding:
      position: 102
      prefix: --no-ansi
  - id: no_data_dir
    type:
      - 'null'
      - boolean
    doc: Prevent the parsed data directory from being created.
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
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Create report in the specified output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: pdf_report
    type:
      - 'null'
      - boolean
    doc: Creates PDF report with 'simple' template. Requires Pandoc to be 
      installed.
    inputBinding:
      position: 102
      prefix: --pdf
  - id: prepend_dirs
    type:
      - 'null'
      - boolean
    doc: Prepend directory to sample names
    inputBinding:
      position: 102
      prefix: --dirs
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
  - id: sample_filters
    type:
      - 'null'
      - File
    doc: File containing show/hide patterns for the report
    inputBinding:
      position: 102
      prefix: --sample-filters
  - id: sample_names
    type:
      - 'null'
      - File
    doc: File containing alternative sample names
    inputBinding:
      position: 102
      prefix: --sample-names
  - id: tag
    type:
      - 'null'
      - string
    doc: Use only modules which tagged with this keyword, eg. RNA
    inputBinding:
      position: 102
      prefix: --tag
  - id: template
    type:
      - 'null'
      - string
    doc: Report template to use.
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
      - boolean
    doc: Increase output verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: view_tags
    type:
      - 'null'
      - boolean
    doc: View the available tags and which modules they load
    inputBinding:
      position: 102
      prefix: --view-tags
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
    dockerPull: quay.io/biocontainers/multiqc-bcbio:0.2.9--pyh3252c3a_0
stdout: multiqc-bcbio_multiqc.out
