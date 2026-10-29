cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagenomics.py
  - report_merge
label: viral-ngs_metagenomics_report_merge
doc: "Merge multiple metegenomic reports into a single metagenomic report. Any Krona input files created by this\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: metagenomic_reports
    type:
      type: array
      items: File
    doc: "Input metagenomic reports with the query ID and taxon ID in the 2nd and 3rd columns (Kraken format)"
    inputBinding:
      position: 1
  - id: out_summary_report
    type:
      - 'null'
      - string
    doc: "Path of human-readable metagenomic summary report, created by kraken-report"
    inputBinding:
      position: 20
      prefix: --outSummaryReport
  - id: kraken_db
    type:
      - 'null'
      - File
    doc: "Kraken database (needed for outSummaryReport)"
    inputBinding:
      position: 20
      prefix: --krakenDB
  - id: out_by_query_to_taxon_id
    type:
      - 'null'
      - string
    doc: "Output metagenomic report suitable for Krona input."
    inputBinding:
      position: 20
      prefix: --outByQueryToTaxonID
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_summary_report_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_summary_report"
    outputBinding:
      glob: $(inputs.out_summary_report)
  - id: out_by_query_to_taxon_id_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_by_query_to_taxon_id"
    outputBinding:
      glob: $(inputs.out_by_query_to_taxon_id)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
