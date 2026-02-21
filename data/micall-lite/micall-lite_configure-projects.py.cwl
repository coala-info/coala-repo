cwlVersion: v1.2
class: CommandLineTool
baseCommand: micall-lite_configure-projects.py
label: micall-lite_configure-projects.py
doc: "A tool to configure projects for micall-lite. (Note: The provided help text
  contains only system error logs and does not list available arguments.)\n\nTool
  homepage: https://github.com/PoonLab/MiCall-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/micall-lite:0.1rc--py27h14c3975_0
stdout: micall-lite_configure-projects.py.out
