cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne
doc: "Estimation of historical effective population size from segments of Identity
  By Descent (IBD). Note: The provided help text contains only system error messages
  and no usage information.\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne.out
