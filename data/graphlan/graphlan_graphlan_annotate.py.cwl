cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphlan_annotate.py
label: graphlan_graphlan_annotate.py
doc: "GraPhlAn annotation tool (Note: The provided text contains container runtime
  error messages and does not include the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://bitbucket.org/nsegata/graphlan/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/graphlan:v1.1.3-1-deb_cv1
stdout: graphlan_graphlan_annotate.py.out
