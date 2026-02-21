cwlVersion: v1.2
class: CommandLineTool
baseCommand: spine_spine.pl
label: spine_spine.pl
doc: "The provided text does not contain help information for spine_spine.pl. It appears
  to be a container engine error log.\n\nTool homepage: https://github.com/egonozer/Spine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spine:0.3.2--pl526_0
stdout: spine_spine.pl.out
