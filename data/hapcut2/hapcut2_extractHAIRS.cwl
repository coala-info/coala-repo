cwlVersion: v1.2
class: CommandLineTool
baseCommand: extractHAIRS
label: hapcut2_extractHAIRS
doc: "The provided text is an error log and does not contain a description of the
  tool.\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
stdout: hapcut2_extractHAIRS.out
