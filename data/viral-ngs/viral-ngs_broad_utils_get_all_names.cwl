cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - broad_utils.py
  - get_all_names
label: viral-ngs_broad_utils_get_all_names
doc: "Get all samples\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: name_type
    type:
      type: enum
      symbols:
        - samples
        - libraries
        - runs
    doc: "Type of name"
    inputBinding:
      position: 1
  - id: runfile
    type: File
    doc: "File with seq run information"
    inputBinding:
      position: 2
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
    doc: "Verboseness of output. [default: ERROR]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: barcode_files
    type:
      type: array
      items: File
    doc: "Barcode files named in the barcode_file column of the run file; they are staged in the working directory so the relative names resolve."
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.barcode_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_broad_utils_get_all_names.out
