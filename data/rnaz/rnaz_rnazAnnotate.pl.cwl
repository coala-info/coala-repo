cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazAnnotate.pl
label: rnaz_rnazAnnotate.pl
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error log from a container runtime (Apptainer/Singularity) attempting to
  pull the RNAz image.\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazAnnotate.pl.out
