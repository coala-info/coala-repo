cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop_add_prefix_to_cool.py
label: neoloop_add_prefix_to_cool.py
doc: "Adds a prefix to the chromosome names in a .cool file.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: input_cool
    type: File
    doc: Input .cool file
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: Prefix to add to chromosome names
    inputBinding:
      position: 2
outputs:
  - id: output_cool
    type:
      - 'null'
      - File
    doc: 'Output .cool file (default: overwrites input)'
    outputBinding:
      glob: $(inputs.output_cool)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
