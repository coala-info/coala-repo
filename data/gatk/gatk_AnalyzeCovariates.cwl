cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - AnalyzeCovariates
label: gatk_AnalyzeCovariates
doc: Evaluate and compare base quality score recalibration (BQSR) tables
inputs:
  - id: after_report_file
    type: File
    doc: file containing the BQSR second-pass report file
    inputBinding:
      position: 101
      prefix: --after-report-file
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: before_report_file
    type:
      - 'null'
      - File
    doc: file containing the BQSR first-pass report file
    inputBinding:
      position: 101
      prefix: --before-report-file
  - id: bqsr_recal_file
    type:
      - 'null'
      - File
    doc: Input covariates table file for on-the-fly base quality score 
      recalibration
    inputBinding:
      position: 101
      prefix: --bqsr-recal-file
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 101
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets. If unset, 
      these buckets cannot be accessed.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: ignore_last_modification_times
    type:
      - 'null'
      - boolean
    doc: do not emit warning messages related to suspicious last modification 
      time order of inputs
    inputBinding:
      position: 101
      prefix: --ignore-last-modification-times
  - id: intermediate_csv_file
    type: string
    doc: location of the csv intermediate file
    inputBinding:
      position: 101
      prefix: --intermediate-csv-file
  - id: plots_report_file
    type: string
    doc: location of the output report
    inputBinding:
      position: 101
      prefix: --plots-report-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-inflater
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_intermediate_csv_file
    type:
      - 'null'
      - File
    doc: location of the csv intermediate file
    outputBinding:
      glob: $(inputs.intermediate_csv_file)
  - id: output_plots_report_file
    type:
      - 'null'
      - File
    doc: location of the output report
    outputBinding:
      glob: $(inputs.plots_report_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
