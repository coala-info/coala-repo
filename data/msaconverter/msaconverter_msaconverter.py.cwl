cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaconverter.py
label: msaconverter_msaconverter.py
doc: "A tool for converting Multiple Sequence Alignment (MSA) files. (Note: The provided
  help text contains only system error messages and no argument definitions.)\n\n
  Tool homepage: https://github.com/linzhi2013/msaconverter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaconverter:0.0.4--pyhdfd78af_0
stdout: msaconverter_msaconverter.py.out
