cwlVersion: v1.2
class: CommandLineTool
baseCommand: karect
label: karect_align
doc: "A suite of tools for assembly read correction, alignment, evaluation, and merging.\n\
  \nTool homepage: https://github.com/aminallam/karect"
inputs:
  - id: align
    type:
      - 'null'
      - boolean
    doc: a tool to align original assembly reads as pre-processing for 
      evaluation.
    inputBinding:
      position: 101
  - id: correct
    type:
      - 'null'
      - boolean
    doc: a tool to correct assembly reads from fasta/fastq files.
    inputBinding:
      position: 101
  - id: eval
    type:
      - 'null'
      - boolean
    doc: a tool to evaluate assembly reads correction.
    inputBinding:
      position: 101
  - id: merge
    type:
      - 'null'
      - boolean
    doc: a tool to concatenate fasta/fastq files.
    inputBinding:
      position: 101
  - id: tool
    type: string
    doc: 'Specify the tool to run: correct, align, eval, or merge.'
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
stdout: karect_align.out
