cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_PLINK
doc: "IBDNe is a program that estimates historical effective population size from
  segments of identity by descent (IBD) shared by sampled individuals.\n\nTool homepage:
  https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_PLINK.out
