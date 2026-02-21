cwlVersion: v1.2
class: CommandLineTool
baseCommand: json_collect_data_source
label: json_collect_data_source
doc: "A tool to collect data source information and output it in JSON format.\n\n
  Tool homepage: https://github.com/fabio-cumbo/galaxy-json-collect-data-source"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/json_collect_data_source:1.0.1--2
stdout: json_collect_data_source.out
