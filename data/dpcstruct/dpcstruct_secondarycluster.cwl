cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpcstruct-secondarycluster
label: dpcstruct_secondarycluster
doc: "Perform secondary clustering operations.\n\nTool homepage: https://github.com/RitAreaSciencePark/DPCstruct"
inputs:
  - id: mode
    type: string
    doc: "The mode of operation: 'distance' or 'classify'."
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Mode-specific options.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
stdout: dpcstruct_secondarycluster.out
