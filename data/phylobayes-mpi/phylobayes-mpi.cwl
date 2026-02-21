cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylobayes-mpi
label: phylobayes-mpi
doc: "PhyloBayes MPI (Note: The provided text is a container execution error log and
  does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/bayesiancook/pbmpi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi.out
