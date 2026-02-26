cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_setup.rb
label: protk_protk_setup.rb
doc: "Post install tasks for protk.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: setup_task
    type: string
    doc: The setup task to perform (e.g., all, system_packages) or the specific 
      tool name to set up.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_protk_setup.rb.out
