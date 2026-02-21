cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredHisto
label: ucsc-genepredhisto
doc: "The provided text does not contain help information as it is a fatal error log
  from a container runtime (Apptainer/Singularity) attempting to pull the tool image.
  Under normal circumstances, this tool creates a histogram of gene prediction lengths.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredhisto:482--h0b57e2e_0
stdout: ucsc-genepredhisto.out
