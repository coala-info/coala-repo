cwlVersion: v1.2
class: CommandLineTool
baseCommand: micall-lite_project-editor.py
label: micall-lite_project-editor.py
doc: "Project editor for micall-lite (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/PoonLab/MiCall-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micall-lite:0.1rc--py27h14c3975_0
stdout: micall-lite_project-editor.py.out
