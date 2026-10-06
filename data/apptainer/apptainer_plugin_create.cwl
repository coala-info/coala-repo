cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - plugin
  - create
label: apptainer_plugin_create
doc: "The 'plugin create' command allows a user to creates a plugin skeleton directory
  structure to start development of a new plugin.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: host_path
    type: string
    doc: Directory to create for the plugin skeleton
    default: plugin
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: Plugin name, e.g. github.com/username/myplugin
    inputBinding:
      position: 2
outputs:
  - id: plugin_dir
    type: Directory
    doc: Plugin skeleton directory (go.mod, main.go)
    outputBinding:
      glob: $(inputs.host_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
