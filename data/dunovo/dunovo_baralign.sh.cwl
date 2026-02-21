cwlVersion: v1.2
class: CommandLineTool
baseCommand: dunovo_baralign.sh
label: dunovo_baralign.sh
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container due to lack of
  disk space.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo_baralign.sh.out
