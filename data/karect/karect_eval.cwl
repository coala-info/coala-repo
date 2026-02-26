cwlVersion: v1.2
class: CommandLineTool
baseCommand: karect
label: karect_eval
doc: "A suite of tools for assembly read correction, alignment, evaluation, and merging.\n\
  \nTool homepage: https://github.com/aminallam/karect"
inputs:
  - id: tool
    type: string
    doc: 'Specify the tool to run: correct, align, eval, or merge.'
    inputBinding:
      position: 101
      prefix: '-'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9
stdout: karect_eval.out
