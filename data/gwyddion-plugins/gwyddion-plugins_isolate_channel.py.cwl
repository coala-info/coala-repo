cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwyddion-plugins_isolate_channel.py
label: gwyddion-plugins_isolate_channel.py
doc: "A Gwyddion plugin script to isolate a specific channel. Note: The provided help
  text contains system execution errors and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/tuxu/gwyddion-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwyddion-plugins:v2.52-1-deb_cv1
stdout: gwyddion-plugins_isolate_channel.py.out
