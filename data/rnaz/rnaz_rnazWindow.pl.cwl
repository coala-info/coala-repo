cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazWindow.pl
label: rnaz_rnazWindow.pl
doc: "The provided text does not contain help information for rnazWindow.pl; it is
  an error log from a container runtime (Singularity/Apptainer) failing to fetch the
  OCI image.\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazWindow.pl.out
