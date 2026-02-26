cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sopa
  - report
label: sopa_report
doc: "Create a HTML report of the pipeline run and some quality controls\n\nTool homepage:
  https://gustaveroussy.github.io/sopa"
inputs:
  - id: sdata_path
    type: string
    doc: Path to the SpatialData `.zarr` directory
    inputBinding:
      position: 1
  - id: path
    type: string
    doc: Path to the HTML report
    inputBinding:
      position: 2
  - id: table_key
    type:
      - 'null'
      - string
    doc: Key of the table in the `SpatialData` object to be used for the report
    default: table
    inputBinding:
      position: 103
      prefix: --table-key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
stdout: sopa_report.out
