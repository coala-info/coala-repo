cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-bigwigcluster
label: ucsc-bigwigcluster
doc: "Clustering bigWig files. Note: The provided help text contains a fatal system
  error (no space left on device) and does not list usage or arguments.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigcluster:482--h0b57e2e_0
stdout: ucsc-bigwigcluster.out
