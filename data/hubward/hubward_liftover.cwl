cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hubward
  - liftover
label: hubward_liftover
doc: "Lift over coordinates from one assembly to another, in bulk. For all configured
  tracks in <dirname>/metadata.yaml, if the configured track genome matches <from_assembly>
  then perform the liftover to a temporary directory and then move the result to <newdir>
  when complete.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: dirname
    type: Directory
    doc: Single study to liftover
    inputBinding:
      position: 1
  - id: from_assembly
    type:
      - 'null'
      - string
    doc: Source assembly
    default: '-'
    inputBinding:
      position: 102
      prefix: --from_assembly
  - id: to_assembly
    type:
      - 'null'
      - string
    doc: Destination assembly
    default: '-'
    inputBinding:
      position: 102
      prefix: --to_assembly
outputs:
  - id: newdir
    type: Directory
    doc: Destination directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
