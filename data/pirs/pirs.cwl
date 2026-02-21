cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs
label: pirs
doc: "Profile-based Illumina pair-end Read Simulator (Note: The provided text contained
  only system error logs and no help documentation).\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
stdout: pirs.out
