cwlVersion: v1.2
class: CommandLineTool
baseCommand: vrhyme_test_vRhyme.py
label: vrhyme_test_vRhyme.py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/execution.\n\nTool homepage: https://github.com/AnantharamanLab/vRhyme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vrhyme:1.1.0--pyhdfd78af_1
stdout: vrhyme_test_vRhyme.py.out
