cwlVersion: v1.2
class: CommandLineTool
baseCommand: AMAS
label: amas_AMAS.py
doc: "AMAS (Alignment Manipulation and Summary) is a tool for manipulating and summarizing
  DNA and protein alignments.\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: command
    type: string
    doc: Subcommand to run (concat, convert, replicate, split, summary, remove, 
      translate, or trim)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
stdout: amas_AMAS.py.out
