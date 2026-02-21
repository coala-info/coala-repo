cwlVersion: v1.2
class: CommandLineTool
baseCommand: treeview
label: treeview
doc: "The provided text does not contain help information or usage instructions for
  the 'treeview' command. It contains error logs related to a failed container build
  process (no space left on device).\n\nTool homepage: https://github.com/jonmiles/bootstrap-treeview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/treeview:v1.1.6.4dfsg1-4-deb_cv1
stdout: treeview.out
