cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilea
label: pilea_new
doc: "pilea: error: argument {index,fetch,profile,rebuild}: invalid choice: 'new'
  (choose from index, fetch, profile, rebuild)\n\nTool homepage: https://github.com/xinehc/pilea"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute (index, fetch, profile, rebuild)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
stdout: pilea_new.out
