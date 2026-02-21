cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxt2new
label: phyx_pxt2new
doc: "Converts a tree file (newick or nexus) to newick format.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: tree_file
    type:
      - 'null'
      - File
    doc: input tree file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --treef
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output tree file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
