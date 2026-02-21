cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribocode
label: ribocode
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution attempt.\n\nTool homepage:
  https://github.com/xryanglab/RiboCode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode.out
