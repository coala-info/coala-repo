cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterGenes
label: ucsc-clustergenes
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log. clusterGenes is a UCSC Genome Browser utility
  used to cluster genes based on overlapping exons.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-clustergenes:377--h199ee4e_0
stdout: ucsc-clustergenes.out
