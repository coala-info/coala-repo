cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxmono]
label: phyx_pxmono
doc: |-
  Monophyly checker.
  This will take a newick- or nexus-formatted tree from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: names
    type: ['null', string]
    doc: "names separated by commas (NO SPACES!)"
    inputBinding:
      prefix: -n
  - id: names_file
    type: ['null', File]
    doc: "names in a file (each on a line)"
    inputBinding:
      prefix: -f
  - id: comp
    type: ['null', boolean]
    doc: "take the complement (i.e. check monophyly of taxa not in list)"
    inputBinding:
      prefix: -c
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
  - id: ignore
    type: ['null', boolean]
    doc: "ignore missing (default: exit if names are not in the tree)"
    inputBinding:
      prefix: -i
outputs:
  - id: out_file
    type: File
    doc: "monophyly result"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
