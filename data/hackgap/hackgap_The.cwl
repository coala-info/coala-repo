cwlVersion: v1.2
class: CommandLineTool
baseCommand: hackgap
label: hackgap_The
doc: "hackgap: error: argument COMMAND: invalid choice: 'The' (choose from count,
  countwith, pycount, info)\n\nTool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs:
  - id: command
    type:
      type: array
      items: string
    doc: Command to execute (choose from count, countwith, pycount, info)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
stdout: hackgap_The.out
