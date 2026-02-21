cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaclust
label: rnaclust
doc: "A tool for clustering large sets of RNA sequences (Note: The provided help text
  contains only container build errors and no usage information).\n\nTool homepage:
  http://www.bioinf.uni-leipzig.de/~kristin/Software/RNAclust/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaclust:1.3--pl5.22.0_0
stdout: rnaclust.out
