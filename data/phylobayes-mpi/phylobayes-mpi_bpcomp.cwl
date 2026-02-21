cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpcomp
label: phylobayes-mpi_bpcomp
doc: "The provided text contains container execution error logs rather than the tool's
  help documentation. No arguments could be extracted.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_bpcomp.out
