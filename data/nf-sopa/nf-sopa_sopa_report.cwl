cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sopa, report]
label: nf-sopa_sopa_report
doc: "Create a HTML report of the pipeline run and some quality controls\n\nTool homepage: https://gustaveroussy.github.io/sopa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sdata
    type: Directory
    doc: Path to the SpatialData .zarr directory
    inputBinding:
      position: 1
  - id: report_path
    type: string
    doc: Path to the HTML report
    inputBinding:
      position: 2
  - id: table_key
    type: ['null', string]
    doc: Key of the table in the SpatialData object to be used for the report (default table)
    inputBinding:
      position: 3
      prefix: --table-key
outputs:
  - id: report_html
    type: File
    doc: HTML report
    outputBinding:
      glob: $(inputs.report_path)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: sopa_report.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
