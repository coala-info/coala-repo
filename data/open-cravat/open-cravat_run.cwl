cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oc
  - run
label: open-cravat_run
doc: "Run an Open-CRAVAT job: convert variants, map to genes, annotate and write reports.\n\nTool homepage: http://www.opencravat.org"
inputs:
  - id: inputs
    type: File[]
    doc: "Input variant file(s), for example VCF. Must come first."
    inputBinding:
      position: 1
  - id: annotators
    type:
      - 'null'
      - string[]
    doc: "Annotator module names or directories."
    inputBinding:
      position: 101
      prefix: "-a"
  - id: annotators_replace
    type:
      - 'null'
      - string[]
    doc: "Annotator module names or directories; replaces those of --package. Has priority over -a."
    inputBinding:
      position: 101
      prefix: "-A"
  - id: excludes
    type:
      - 'null'
      - string[]
    doc: "Annotators to exclude."
    inputBinding:
      position: 101
      prefix: "-e"
  - id: run_name
    type:
      - 'null'
      - string
    doc: "Name of the run."
    inputBinding:
      position: 101
      prefix: "-n"
  - id: output_dir_name
    type:
      - 'null'
      - string
    doc: "Directory for output files."
    inputBinding:
      position: 101
      prefix: "-d"
  - id: startat
    type:
      - 'null'
      - string
    doc: "Start at this stage (converter, mapper, annotator, aggregator, postaggregator, reporter)."
    inputBinding:
      position: 101
      prefix: "--startat"
  - id: endat
    type:
      - 'null'
      - string
    doc: "End after this stage."
    inputBinding:
      position: 101
      prefix: "--endat"
  - id: skip
    type:
      - 'null'
      - string[]
    doc: "Skip the given stage(s)."
    inputBinding:
      position: 101
      prefix: "--skip"
  - id: conf
    type:
      - 'null'
      - File
    doc: "Path to a conf file."
    inputBinding:
      position: 101
      prefix: "-c"
  - id: confs
    type:
      - 'null'
      - string
    doc: "Configuration string."
    inputBinding:
      position: 101
      prefix: "--cs"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose."
    inputBinding:
      position: 101
      prefix: "-v"
  - id: reports
    type:
      - 'null'
      - string[]
    doc: "Reporter types or reporter module directories."
    inputBinding:
      position: 101
      prefix: "-t"
  - id: liftover
    type:
      - 'null'
      - string
    doc: "Reference genome of the input (hg38, hg19, hg18); lifted over to hg38 if needed."
    inputBinding:
      position: 101
      prefix: "-l"
  - id: clean_db
    type:
      - 'null'
      - boolean
    doc: "Delete the existing result database and create a new one."
    inputBinding:
      position: 101
      prefix: "-x"
  - id: newlog
    type:
      - 'null'
      - boolean
    doc: "Delete the existing log file and create a new one."
    inputBinding:
      position: 101
      prefix: "--newlog"
  - id: note
    type:
      - 'null'
      - string
    doc: "Note written to the run status file (.status.json)."
    inputBinding:
      position: 101
      prefix: "--note"
  - id: mp
    type:
      - 'null'
      - int
    doc: "Number of processes to use to run annotators."
    inputBinding:
      position: 101
      prefix: "--mp"
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Force input format (cravat, hgvs, oldcravat, vcf, clingen)."
    inputBinding:
      position: 101
      prefix: "-i"
  - id: temp_files
    type:
      - 'null'
      - boolean
    doc: "Leave temporary files after the run is complete."
    inputBinding:
      position: 101
      prefix: "--temp-files"
  - id: writeadmindb
    type:
      - 'null'
      - boolean
    doc: "Write job information to the admin db after the job completes."
    inputBinding:
      position: 101
      prefix: "--writeadmindb"
  - id: jobid
    type:
      - 'null'
      - string
    doc: "Job ID for the server version."
    inputBinding:
      position: 101
      prefix: "--jobid"
  - id: separatesample
    type:
      - 'null'
      - boolean
    doc: "Separate variant results by sample."
    inputBinding:
      position: 101
      prefix: "--separatesample"
  - id: primary_transcript
    type:
      - 'null'
      - string[]
    doc: "\"mane\" for MANE transcripts as primary transcripts, or a path to a file of primary transcripts."
    inputBinding:
      position: 101
      prefix: "--primary-transcript"
  - id: cleanrun
    type:
      - 'null'
      - boolean
    doc: "Delete all previous output files for the job and generate new ones."
    inputBinding:
      position: 101
      prefix: "--cleanrun"
  - id: do_not_change_status
    type:
      - 'null'
      - boolean
    doc: "Job status in status.json will not be changed."
    inputBinding:
      position: 101
      prefix: "--do-not-change-status"
  - id: module_option
    type:
      - 'null'
      - string[]
    doc: "Module-specific option in module_name.key=value syntax."
    inputBinding:
      position: 101
      prefix: "--module-option"
  - id: system_option
    type:
      - 'null'
      - string[]
    doc: "System option in key=value syntax. Default turns off usage metrics upload, which needs a writable install folder."
    default: ["save_metrics=false"]
    inputBinding:
      position: 101
      prefix: "--system-option"
  - id: user_email
    type:
      - 'null'
      - string
    doc: "User email for OpenCravat metrics."
    inputBinding:
      position: 101
      prefix: "--user-email"
  - id: user_email_opt_out
    type:
      - 'null'
      - boolean
    doc: "Opt out of providing an email for OpenCravat metrics."
    inputBinding:
      position: 101
      prefix: "--user-email-opt-out"
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Run silently."
    inputBinding:
      position: 101
      prefix: "--silent"
  - id: concise_report
    type:
      - 'null'
      - boolean
    doc: "Generate concise reports with the default columns defined by each annotation module."
    inputBinding:
      position: 101
      prefix: "--concise-report"
  - id: package
    type:
      - 'null'
      - string
    doc: "Use package."
    inputBinding:
      position: 101
      prefix: "--package"
  - id: filtersql
    type:
      - 'null'
      - string
    doc: "Filter SQL."
    inputBinding:
      position: 101
      prefix: "--filtersql"
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
  - id: filterpath
    type:
      - 'null'
      - File
    doc: "Path to a filter file."
    inputBinding:
      position: 101
      prefix: "-f"
  - id: md
    type:
      - 'null'
      - string
    doc: "Root directory of OpenCRAVAT modules (annotators, etc)."
    inputBinding:
      position: 101
      prefix: "--md"
  - id: mapper_name
    type:
      - 'null'
      - string[]
    doc: "Mapper module name or directory."
    inputBinding:
      position: 101
      prefix: "-m"
  - id: postaggregators
    type:
      - 'null'
      - string[]
    doc: "Postaggregators to run."
    inputBinding:
      position: 101
      prefix: "-p"
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory with the result database, logs and reports"
    outputBinding:
      glob: $(inputs.output_dir_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
