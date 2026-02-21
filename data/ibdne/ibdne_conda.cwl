cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_conda
doc: "IBDNe is a program for estimating recent effective population size from identity-by-descent
  (IBD) segments. (Note: The provided help text contains only system error messages
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_conda.out
