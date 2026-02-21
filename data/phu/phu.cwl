cwlVersion: v1.2
class: CommandLineTool
baseCommand: phu
label: phu
doc: "Phylogenetic Utility (Note: The provided text is a container build log and does
  not contain help information or argument definitions).\n\nTool homepage: https://github.com/camilogarciabotero/phu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
stdout: phu.out
