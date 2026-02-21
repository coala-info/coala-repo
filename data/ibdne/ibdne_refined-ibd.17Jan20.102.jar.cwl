cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_refined-ibd.17Jan20.102.jar
doc: "IBDNe is a program that estimates historical effective population size from
  segments of Identity By Descent (IBD). (Note: The provided text was an error log
  and did not contain help information.)\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_refined-ibd.17Jan20.102.jar.out
