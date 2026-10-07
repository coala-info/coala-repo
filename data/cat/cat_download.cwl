cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CAT_pack
  - download
label: cat_download
doc: "Download and preprocess sequence and taxonomy information. Currently supports the NCBI non-redundant (nr) database and the GTDB database.\n\nTool homepage: https://github.com/MGXlab/CAT_pack"
inputs:
  - id: db
    type: string
    doc: "Either nr or GTDB."
    inputBinding:
      position: 101
      prefix: --db
  - id: output_dir
    type: string
    doc: "Path to directory where data will be stored."
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: "Remove unnecessary files after all data have been processed."
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: "Suppress log file."
    inputBinding:
      position: 101
      prefix: --no_log
outputs:
  - id: output
    type: Directory
    doc: "Downloaded and preprocessed data"
    outputBinding:
      glob: "$(inputs.output_dir)"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
