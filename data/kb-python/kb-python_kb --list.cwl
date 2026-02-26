cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kb-python
  - kb
  - --list
label: kb-python_kb --list
doc: "List of supported single-cell technologies\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: technology_name
    type:
      - 'null'
      - string
    doc: Name of the single-cell technology
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python_kb --list.out
