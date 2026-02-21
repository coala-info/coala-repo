cwlVersion: v1.2
class: CommandLineTool
baseCommand: datma_runDATMA.sh
label: datma_runDATMA.sh
doc: "DATMA (De novo Assembly and Template-based Mapping) tool\n\nTool homepage: https://github.com/andvides/DATMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datma:2.0--hdfd78af_0
stdout: datma_runDATMA.sh.out
