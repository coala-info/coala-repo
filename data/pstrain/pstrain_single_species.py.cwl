cwlVersion: v1.2
class: CommandLineTool
baseCommand: pstrain_single_species.py
label: pstrain_single_species.py
doc: "PStrain single species analysis tool. (Note: The provided text contains container
  execution logs and error messages rather than the tool's help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/wshuai294/PStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstrain:1.0.3--h9ee0642_0
stdout: pstrain_single_species.py.out
