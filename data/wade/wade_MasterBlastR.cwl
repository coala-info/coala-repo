cwlVersion: v1.2
class: CommandLineTool
baseCommand: wade_MasterBlastR
label: wade_MasterBlastR
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/phac-nml/wade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wade:1.2.0--r44hdfd78af_0
stdout: wade_MasterBlastR.out
