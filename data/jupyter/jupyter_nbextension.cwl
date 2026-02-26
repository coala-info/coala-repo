cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter nbextension
label: jupyter_nbextension
doc: "Work with Jupyter notebook extensions\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Full path of a config file.
    default: ''
    inputBinding:
      position: 101
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 101
      prefix: --debug
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level by value or name.
    default: 30
    inputBinding:
      position: 101
      prefix: --log-level
  - id: py
    type:
      - 'null'
      - boolean
    doc: Install from a Python package
    inputBinding:
      position: 101
      prefix: --py
  - id: python
    type:
      - 'null'
      - boolean
    doc: Install from a Python package
    inputBinding:
      position: 101
      prefix: --python
  - id: sys_prefix
    type:
      - 'null'
      - boolean
    doc: Use sys.prefix as the prefix for installing nbextensions (for 
      environments, packaging)
    inputBinding:
      position: 101
      prefix: --sys-prefix
  - id: system
    type:
      - 'null'
      - boolean
    doc: Apply the operation system-wide
    inputBinding:
      position: 101
      prefix: --system
  - id: user
    type:
      - 'null'
      - boolean
    doc: Apply the operation only for the given user
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_nbextension.out
