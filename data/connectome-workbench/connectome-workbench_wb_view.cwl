cwlVersion: v1.2
class: CommandLineTool
baseCommand: wb_view
label: connectome-workbench_wb_view
doc: "Connectome Workbench visualization tool. Note: The provided text contains system
  error messages regarding container execution and disk space, rather than command-line
  help documentation. No arguments could be extracted from the input.\n\nTool homepage:
  https://www.humanconnectome.org/software/connectome-workbench"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
stdout: connectome-workbench_wb_view.out
