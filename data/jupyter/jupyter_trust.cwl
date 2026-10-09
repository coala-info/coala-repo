cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jupyter
  - trust
label: jupyter_trust
doc: "Sign one or more Jupyter notebooks with your key, to trust their dynamic (HTML,\nJavascript) output.\n\nOtherwise, you will have to re-execute the notebook to see output.\n\nTool homepage: https://github.com/jupyter/jupyter_core"
inputs:
  - id: notebook_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Notebook files to sign
    inputBinding:
      position: 10
  - id: reset
    type:
      - 'null'
      - boolean
    doc: Delete the trusted notebook cache. All previously signed notebooks will become untrusted.
    inputBinding:
      position: 1
      prefix: --reset
  - id: generate_config
    type:
      - 'null'
      - boolean
    doc: generate default config file
    inputBinding:
      position: 1
      prefix: --generate-config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 1
      prefix: --debug
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any questions instead of prompting.
    inputBinding:
      position: 1
      prefix: -y
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
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages, including the notebooks that were signed
  - id: signature_db
    type:
      - 'null'
      - File
    doc: Database of notebook signatures written by the run
    outputBinding:
      glob: .local/share/jupyter/nbsignatures.db
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_trust.out
stderr: jupyter_trust.err
