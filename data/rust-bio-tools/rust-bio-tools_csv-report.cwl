cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - csv-report
label: rust-bio-tools_csv-report
doc: "Creates report from a given csv file containing a table with the given data\n\
  \nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: csv_path
    type: File
    doc: CSV file including the data for the report
    inputBinding:
      position: 1
  - id: formatter
    type:
      - 'null'
      - File
    doc: Configure a custom formatter function for each column by providing a 
      file containing a javascript object with csv column title as the key and a
      format function as the value.
    inputBinding:
      position: 102
      prefix: --formatter
  - id: pin_until
    type:
      - 'null'
      - string
    doc: Pins the table until the given column such that scrolling to the right 
      does not hide the given column and those before
    inputBinding:
      position: 102
      prefix: --pin-until
  - id: rows_per_page
    type:
      - 'null'
      - int
    doc: Sets the numbers of rows of each table per page. Default is 100
    inputBinding:
      position: 102
      prefix: --rows-per-page
  - id: separator
    type:
      - 'null'
      - string
    doc: Change the separator of the csv file to tab or anything else. Default 
      is ","
    inputBinding:
      position: 102
      prefix: --separator
  - id: sort_column
    type:
      - 'null'
      - string
    doc: Column that the data should be sorted by
    inputBinding:
      position: 102
      prefix: --sort-column
  - id: sort_order
    type:
      - 'null'
      - string
    doc: Order the data ascending or descending. Default is descending
    inputBinding:
      position: 102
      prefix: --sort-order
  - id: output_path
    type: string
    doc: Relative output path for the report files (a new folder)
    inputBinding:
      position: 2
outputs:
  - id: report_dir
    type: Directory
    doc: Folder with the HTML report files
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
