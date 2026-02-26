cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgatools
label: wgatools_Output
doc: "A command-line tool for various genomic analyses.\n\nTool homepage: https://github.com/wjwei-handsome/wgatools"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
stdout: wgatools_Output.out
