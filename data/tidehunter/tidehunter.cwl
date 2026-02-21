cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidehunter
label: tidehunter
doc: "A tool for tandem repeat detection (Note: The provided text contains environment
  logs and error messages rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/yangao07/TideHunter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidehunter:1.5.5--h5ca1c30_3
stdout: tidehunter.out
