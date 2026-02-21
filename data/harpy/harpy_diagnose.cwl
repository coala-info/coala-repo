cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - diagnose
label: harpy_diagnose
doc: "Diagnose issues within a harpy directory\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: directory
    type: Directory
    doc: The directory to diagnose
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_diagnose.out
