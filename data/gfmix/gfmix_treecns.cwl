cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfmix_treecns
label: gfmix_treecns
doc: "A tool from the gfmix package (Gene Family Mix). Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: https://www.mathstat.dal.ca/~tsusko/doc/gfmix.pdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfmix:1.0.2--h503566f_3
stdout: gfmix_treecns.out
