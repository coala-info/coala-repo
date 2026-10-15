cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, utils, parquet-to-csv]
label: pore-c_utils_parquet-to-csv
doc: "Convert a parquet file to CSV.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: input_parquet
    type: File
    doc: "Input parquet file"
    inputBinding:
      position: 10
  - id: output_csv
    type: string
    doc: "Output CSV file name"
    inputBinding:
      position: 11
outputs:
  - id: csv
    type: File
    doc: "CSV file"
    outputBinding:
      glob: "$(inputs.output_csv)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
