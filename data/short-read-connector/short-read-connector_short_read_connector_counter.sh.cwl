cwlVersion: v1.2
class: CommandLineTool
baseCommand: short_read_connector_counter.sh
label: short-read-connector_short_read_connector_counter.sh
doc: "Compare reads from two read sets (distinct or not)\n\nTool homepage: https://github.com/GATB/short_read_connector"
inputs:
  - id: index_query
    type: string
    doc: index/query
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
stdout: short-read-connector_short_read_connector_counter.sh.out
