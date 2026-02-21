cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - plugin
label: apptainer_plugin
doc: "The 'plugin' command allows you to manage Apptainer plugins which provide add-on
  functionality to the default Apptainer installation.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type: string
    doc: The plugin management command to execute (compile, create, disable, enable,
      inspect, install, list, uninstall)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_plugin.out
