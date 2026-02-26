cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_trust
label: jupyter_trust
doc: "Trust or untrust a notebook.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: notebook_files
    type:
      type: array
      items: File
    doc: Notebook files to trust or untrust.
    inputBinding:
      position: 1
  - id: trust
    type:
      - 'null'
      - boolean
    doc: Trust the specified notebook(s).
    inputBinding:
      position: 102
      prefix: --trust
  - id: untrust
    type:
      - 'null'
      - boolean
    doc: Untrust the specified notebook(s).
    inputBinding:
      position: 102
      prefix: --untrust
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_trust.out
