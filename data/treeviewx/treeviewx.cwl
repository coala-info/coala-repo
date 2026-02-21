cwlVersion: v1.2
class: CommandLineTool
baseCommand: treeviewx
label: treeviewx
doc: "A tool for displaying phylogenetic trees. (Note: The provided text contains
  container build error logs rather than help documentation, so specific arguments
  could not be extracted.)\n\nTool homepage: https://github.com/name2name2/TreeViewXMLTest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/treeviewx:v0.5.120100823-4-deb_cv1
stdout: treeviewx.out
