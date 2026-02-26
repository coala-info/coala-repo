cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ov
  - module
label: oakvar_ov module search
doc: "Manage ov modules\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: command
    type: string
    doc: The module subcommand to run (install, pack, update, uninstall, info, 
      ls, create)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov module search.out
