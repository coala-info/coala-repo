cwlVersion: v1.2
class: CommandLineTool
baseCommand: flowcraft_report
label: flowcraft_report
doc: "Generate a report from pipeline execution data.\n\nTool homepage: https://github.com/assemblerflow/flowcraft"
inputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Specify the nextflow log file. Only applicable in combination with 
      --watch option.
    inputBinding:
      position: 101
      prefix: --log-file
  - id: report_file
    type:
      - 'null'
      - File
    doc: Specify the path to the pipeline report JSON file.
    inputBinding:
      position: 101
      prefix: -i
  - id: trace_file
    type:
      - 'null'
      - File
    doc: Specify the nextflow trace file. Only applicable in combination with 
      --watch option.
    inputBinding:
      position: 101
      prefix: --trace-file
  - id: url
    type:
      - 'null'
      - string
    doc: Specify the URL to where the data should be broadcast
    inputBinding:
      position: 101
      prefix: --url
  - id: watch
    type:
      - 'null'
      - boolean
    doc: Run the report in watch mode. This option will track the generation of 
      reports during the execution of the pipeline, allowing for the 
      visualization of the reports in real-time
    inputBinding:
      position: 101
      prefix: --watch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flowcraft:1.4.1--py_1
stdout: flowcraft_report.out
