cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_troubleshoot
label: jupyter_troubleshoot
doc: "Troubleshoot Jupyter installation and environment.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: path
    type:
      - 'null'
      - string
    doc: Path to check for executables.
    inputBinding:
      position: 1
  - id: sys_path
    type:
      - 'null'
      - string
    doc: Python sys.path to check.
    inputBinding:
      position: 2
  - id: sys_executable
    type:
      - 'null'
      - string
    doc: Python executable path to check.
    inputBinding:
      position: 3
  - id: sys_version
    type:
      - 'null'
      - string
    doc: Python version to check.
    inputBinding:
      position: 4
  - id: platform_platform
    type:
      - 'null'
      - string
    doc: Platform information to check.
    inputBinding:
      position: 5
  - id: which_jupyter
    type:
      - 'null'
      - string
    doc: Path to the jupyter executable to check.
    inputBinding:
      position: 6
  - id: conda_list
    type:
      - 'null'
      - string
    doc: Output of 'conda list' to analyze.
    inputBinding:
      position: 7
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_troubleshoot.out
