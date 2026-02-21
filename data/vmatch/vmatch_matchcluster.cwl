cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatch_matchcluster
label: vmatch_matchcluster
doc: "A tool for clustering matches found by vmatch. (Note: The provided help text
  contains only system error messages and no usage information.)\n\nTool homepage:
  http://www.vmatch.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_matchcluster.out
