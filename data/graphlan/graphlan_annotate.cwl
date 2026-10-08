cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphlan_annotate
label: graphlan_annotate
doc: "GraPhlAn annotate module: adds structural and graphical annotations (colors, labels,
  shadows, rings, ...) from an annotation file to an input tree and writes a PhyloXML
  tree for graphlan.\n\nTool homepage: https://bitbucket.org/nsegata/graphlan/wiki/Home"
inputs:
  - id: input_tree
    type: File
    doc: the input tree in Newick, Nexus, PhyloXML or plain text format
    inputBinding:
      position: 1
  - id: output_tree
    type: string
    doc: the output tree in PhyloXML format containing the newly added annotations
    inputBinding:
      position: 2
  - id: annot
    type:
      - 'null'
      - File
    doc: specify the annotation file
    inputBinding:
      position: 0
      prefix: --annot
outputs:
  - id: out_output_tree
    type: File
    doc: Annotated tree in PhyloXML format
    outputBinding:
      glob: $(inputs.output_tree)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/graphlan:v1.1.3-1-deb_cv1
stdout: graphlan_annotate.out
