cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsidx
label: rsidx_subcmd
doc: "Subcommand dispatcher for rsidx. Use 'index' or 'search'.\n\nTool homepage:
  https://github.com/bioforensics/rsidx/"
inputs:
  - id: subcmd
    type: string
    doc: The subcommand to run (choose from index, search)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsidx:0.3.1--pyhdfd78af_0
stdout: rsidx_subcmd.out
