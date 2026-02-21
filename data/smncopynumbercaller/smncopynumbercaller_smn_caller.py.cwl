cwlVersion: v1.2
class: CommandLineTool
baseCommand: smn_caller.py
label: smncopynumbercaller_smn_caller.py
doc: "SMN1 and SMN2 copy number caller\n\nTool homepage: https://github.com/Illumina/SMNCopyNumberCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1
stdout: smncopynumbercaller_smn_caller.py.out
