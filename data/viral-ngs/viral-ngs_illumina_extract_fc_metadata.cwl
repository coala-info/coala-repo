cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - illumina.py
  - extract_fc_metadata
label: viral-ngs_illumina_extract_fc_metadata
doc: "Extract RunInfo.xml and SampleSheet.csv from the provided Illumina directory\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: flowcell
    type:
      - File
      - Directory
    doc: "Illumina directory (possibly tarball)"
    inputBinding:
      position: 1
  - id: out_run_info
    type: string
    doc: "Output RunInfo.xml file."
    inputBinding:
      position: 2
  - id: out_sample_sheet
    type: string
    doc: "Output SampleSheet.csv file."
    inputBinding:
      position: 3
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
  - id: out_run_info_file
    type: File
    doc: "Output file written to out_run_info"
    outputBinding:
      glob: $(inputs.out_run_info)
  - id: out_sample_sheet_file
    type: File
    doc: "Output file written to out_sample_sheet"
    outputBinding:
      glob: $(inputs.out_sample_sheet)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
