cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar_annotateGenesViaCESAR.pl
label: cesar_annotateGenesViaCESAR.pl
doc: "The provided text does not contain help information for the tool. It contains
  system error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar_annotateGenesViaCESAR.pl.out
