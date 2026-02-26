cwlVersion: v1.2
class: CommandLineTool
baseCommand: vispr_server
label: vispr_server
doc: "Start the VISPR server.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs:
  - id: config
    type:
      type: array
      items: File
    doc: YAML config files. Each file points to the results of one MAGeCK run.
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: Host ip location to listen for client connection.
    inputBinding:
      position: 102
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: Port to listen for client connection.
    inputBinding:
      position: 102
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr_server.out
