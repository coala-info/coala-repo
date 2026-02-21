cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeblastdb
label: ncbi-blast-plus_makeblastdb
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failure due
  to insufficient disk space.\n\nTool homepage: https://github.com/ncbi/blast_plus_docs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-blast-plus:v2.8.1-1-deb_cv1
stdout: ncbi-blast-plus_makeblastdb.out
