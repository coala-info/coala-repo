cwlVersion: v1.2
class: CommandLineTool
baseCommand: labrat_LABRAT_danRer.py
label: labrat_LABRAT_danRer.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRAT_danRer.py.out
