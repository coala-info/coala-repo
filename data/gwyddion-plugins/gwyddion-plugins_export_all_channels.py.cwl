cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwyddion-plugins_export_all_channels.py
label: gwyddion-plugins_export_all_channels.py
doc: "Export all channels from Gwyddion files (Note: The provided help text contains
  only container execution errors and no tool-specific usage information).\n\nTool
  homepage: https://github.com/tuxu/gwyddion-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwyddion-plugins:v2.52-1-deb_cv1
stdout: gwyddion-plugins_export_all_channels.py.out
