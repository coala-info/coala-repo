cwlVersion: v1.2
class: CommandLineTool
baseCommand: carnac-lr_paf_to_CARNAC.py
label: carnac-lr_paf_to_CARNAC.py
doc: "A script to convert PAF (Pairwise Mapping Format) files to the format required
  by CARNAC-LR. Note: The provided help text contained system error messages rather
  than usage instructions; arguments could not be extracted from the input.\n\nTool
  homepage: https://github.com/kamimrcht/CARNAC-LR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carnac-lr:1.0.0--h503566f_5
stdout: carnac-lr_paf_to_CARNAC.py.out
