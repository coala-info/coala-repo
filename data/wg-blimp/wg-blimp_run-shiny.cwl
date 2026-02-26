cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wg-blimp
  - run-shiny
label: wg-blimp_run-shiny
doc: "Start shiny GUI using configuration files for completed pipeline runs.\n\nTool
  homepage: https://github.com/MarWoes/wg-blimp"
inputs:
  - id: config_files
    type:
      type: array
      items: string
    doc: Configuration files for completed pipeline runs
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: Host ip for shiny to listen on.
    inputBinding:
      position: 102
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: Shiny port number.
    inputBinding:
      position: 102
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wg-blimp:0.10.0--pyh5e36f6f_0
stdout: wg-blimp_run-shiny.out
