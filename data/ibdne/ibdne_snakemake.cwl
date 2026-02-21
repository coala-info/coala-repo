cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_snakemake
doc: "IBDNe is a program that estimates effective population size from identity-by-descent
  (IBD) segments. (Note: The provided text is a system error log and does not contain
  usage instructions or argument definitions).\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_snakemake.out
