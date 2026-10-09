cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jupyter
  - migrate
label: jupyter_migrate
doc: "Migrate configuration and data from .ipython prior to 4.0 to Jupyter locations.\n\
  \nThis migrates:\n\n- config files in the default profile - kernels in ~/.ipython/kernels
  - notebook\njavascript extensions in ~/.ipython/extensions - custom.js/css to\n\
  .jupyter/custom\n\nto their new Jupyter locations.\n\nAll files are copied, not
  moved. If the destinations already exist, nothing will\nbe done.\n\nTool homepage:
  https://github.com/jupyter/jupyter_core"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .ipython
        entry: $(inputs.ipython_dir)
        writable: true
inputs:
  - id: ipython_dir
    type: Directory
    doc: Old IPython directory (~/.ipython, before IPython 4.0) with the profiles, kernels, extensions and custom files to migrate; it is staged as ~/.ipython
  - id: config_file
    type:
      - 'null'
      - File
    doc: Full path of a config file.
    inputBinding:
      position: 101
      prefix: --config=
      separate: false
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
    inputBinding:
      position: 101
      prefix: --log-level=
      separate: false
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
  - id: stderr
    type: stderr
    doc: Log messages listing the migrated files
  - id: jupyter_config_dir
    type:
      - 'null'
      - Directory
    doc: Migrated Jupyter config folder (~/.jupyter)
    outputBinding:
      glob: .jupyter
  - id: jupyter_data_dir
    type:
      - 'null'
      - Directory
    doc: Migrated Jupyter data folder (~/.local/share/jupyter, with the kernels)
    outputBinding:
      glob: .local/share/jupyter
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_migrate.out
stderr: jupyter_migrate.err
