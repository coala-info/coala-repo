cwlVersion: v1.2
class: CommandLineTool
baseCommand: hackgap
label: hackgap_COMMAND
doc: "hackgap: error: argument COMMAND: invalid choice: 'COMMAND' (choose from count,
  countwith, pycount, info)\n\nTool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: count, countwith, pycount, info'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
stdout: hackgap_COMMAND.out
