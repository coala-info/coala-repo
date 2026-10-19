cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rebar
  - dataset
  - download
label: rebar_dataset_download
doc: "Download a dataset (populations, reference, annotations) for rebar.

Tool homepage: https://github.com/phac-nml/rebar"
inputs:
  - id: name
    type: string
    doc: "Dataset name, for example sars-cov-2 or toy1"
    inputBinding:
      position: 1
      prefix: --name
  - id: tag
    type: string
    doc: "Dataset tag: a date (YYYY-MM-DD), nightly, or custom"
    inputBinding:
      position: 2
      prefix: --tag
  - id: output_dir
    type: string
    doc: "Output directory. It is created if it does not exist"
    inputBinding:
      position: 3
      prefix: --output-dir
  - id: summary
    type:
      - 'null'
      - File
    doc: "Download the dataset from a summary.json snapshot"
    inputBinding:
      position: 4
      prefix: --summary
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Control output verbosity level (info, warn, debug, error). Default is info"
    inputBinding:
      position: 90
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: dataset_dir
    type: Directory
    doc: "Downloaded dataset directory"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
stdout: rebar_dataset_download.out
