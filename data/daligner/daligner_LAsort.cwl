cwlVersion: v1.2
class: CommandLineTool
baseCommand: LAsort
label: daligner_LAsort
doc: "The provided text is an error log from a failed container build and does not
  contain help information for the tool. Based on the tool name hint, LAsort is used
  to sort .las alignment files produced by daligner.\n\nTool homepage: https://github.com/thegenemyers/DALIGNER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_LAsort.out
