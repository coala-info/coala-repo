cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntjoin
label: ntjoin
doc: "The provided text does not contain help information for ntjoin; it contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/ntjoin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntjoin:1.1.5--py312h7896c42_2
stdout: ntjoin.out
