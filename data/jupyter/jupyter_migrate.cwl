cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_migrate
label: jupyter_migrate
doc: "Migrate configuration and data from .ipython prior to 4.0 to Jupyter locations.\n\
  \nThis migrates:\n\n- config files in the default profile - kernels in ~/.ipython/kernels
  - notebook\njavascript extensions in ~/.ipython/extensions - custom.js/css to\n\
  .jupyter/custom\n\nto their new Jupyter locations.\n\nAll files are copied, not
  moved. If the destinations already exist, nothing will\nbe done.\n\nTool homepage:
  https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: config_file
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
  - id: generate_config
    type:
      - 'null'
      - boolean
    doc: generate default config file
    inputBinding:
      position: 101
      prefix: --generate-config
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level by value or name.
    default: 30
    inputBinding:
      position: 101
      prefix: --log-level
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any questions instead of prompting.
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_migrate.out
