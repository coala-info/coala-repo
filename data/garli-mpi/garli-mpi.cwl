cwlVersion: v1.2
class: CommandLineTool
baseCommand: garli-mpi
label: garli-mpi
doc: This MPI version is for doing a large number of search replicates or 
  bootstrap replicates, each using the SAME config file. The results will be 
  exactly identical to those obtained by executing the config file a comparable 
  number of times with the serial version of the program.
inputs:
  - id: num_jobs
    type: int
    doc: Number of times to execute config file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/garli-mpi:v2.1-3-deb_cv1
stdout: garli-mpi.out
