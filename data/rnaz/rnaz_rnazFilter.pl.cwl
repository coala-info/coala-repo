cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazFilter.pl
label: rnaz_rnazFilter.pl
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error related to a container runtime (Apptainer/Singularity)
  failing to fetch a Docker image.\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazFilter.pl.out
