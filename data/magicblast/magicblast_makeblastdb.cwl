cwlVersion: v1.2
class: CommandLineTool
baseCommand: magicblast_makeblastdb
label: magicblast_makeblastdb
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://ncbi.github.io/magicblast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magicblast:1.7.0--hf1761c0_0
stdout: magicblast_makeblastdb.out
