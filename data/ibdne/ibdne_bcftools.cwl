cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_bcftools
label: ibdne_bcftools
doc: "The provided text contains container runtime error messages rather than tool
  help documentation. No arguments or descriptions could be extracted.\n\nTool homepage:
  https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_bcftools.out
