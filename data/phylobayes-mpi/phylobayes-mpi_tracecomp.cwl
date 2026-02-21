cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracecomp
label: phylobayes-mpi_tracecomp
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log. Phylobayes tracecomp is typically used to compare
  several independent MCMC chains and assess convergence.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_tracecomp.out
