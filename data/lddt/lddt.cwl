cwlVersion: v1.2
class: CommandLineTool
baseCommand: lddt
label: lddt
doc: "The provided text does not contain help information or usage instructions for
  the tool 'lddt'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or run the container due to insufficient disk space.\n
  \nTool homepage: https://swissmodel.expasy.org/lddt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lddt:2.2--h9ee0642_0
stdout: lddt.out
