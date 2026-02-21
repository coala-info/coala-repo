cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxrr
label: phyx_pxrr
doc: "Reroot (or unroot) a tree file and produce a newick. This will take a newick-
  or nexus-formatted tree from a file or STDIN. Output is written in newick format.\n
  \nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: outgroups
    type:
      - 'null'
      - string
    doc: outgroup sep by commas (NO SPACES!)
    inputBinding:
      position: 101
      prefix: --outgroups
  - id: ranked
    type:
      - 'null'
      - boolean
    doc: turn on ordering of outgroups. will root on first one present
    inputBinding:
      position: 101
      prefix: --ranked
  - id: silent
    type:
      - 'null'
      - boolean
    doc: do not error if outgroup(s) not found
    inputBinding:
      position: 101
      prefix: --silent
  - id: tree_file
    type:
      - 'null'
      - File
    doc: input tree file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --treef
  - id: unroot
    type:
      - 'null'
      - boolean
    doc: unroot the tree
    inputBinding:
      position: 101
      prefix: --unroot
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
