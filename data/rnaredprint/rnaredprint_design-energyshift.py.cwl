cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaredprint_design-energyshift.py
label: rnaredprint_design-energyshift.py
doc: "A tool for RNA design with energy shift. Note: The provided help text contains
  only container execution errors and no usage information could be extracted.\n\n
  Tool homepage: https://github.com/yannponty/RNARedPrint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
stdout: rnaredprint_design-energyshift.py.out
