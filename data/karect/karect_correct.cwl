cwlVersion: v1.2
class: CommandLineTool
baseCommand: karect
label: karect_correct
doc: "A suite of tools for correcting assembly reads, aligning reads, evaluating corrections,
  and merging files.\n\nTool homepage: https://github.com/aminallam/karect"
inputs:
  - id: tool
    type: string
    doc: 'Specify the tool to run: correct, align, eval, merge'
    inputBinding:
      position: 101
      prefix: --tool
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9
stdout: karect_correct.out
