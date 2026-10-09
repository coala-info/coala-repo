cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jupyter
  - kernelspec
  - list
label: jupyter_kernelspec_list
doc: "List installed kernel specifications.\n\nTool homepage: https://github.com/jupyter/jupyter_client"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 1
      prefix: --debug
  - id: json
    type:
      - 'null'
      - boolean
    doc: output spec name and location as machine-readable json.
    inputBinding:
      position: 1
      prefix: --json
  - id: config
    type:
      - 'null'
      - File
    doc: Full path of a config file.
    inputBinding:
      position: 1
      prefix: --config=
      separate: false
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level by value or name (0, 10, 20, 30, 40, 50, DEBUG, INFO, WARN, ERROR, CRITICAL).
    inputBinding:
      position: 1
      prefix: --log-level=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Installed kernel specifications
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_kernelspec_list.out
