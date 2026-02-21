cwlVersion: v1.2
class: CommandLineTool
baseCommand: libsbml
label: libsbml
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to insufficient disk space.\n\nTool homepage: http://sbml.org/Software/libSBML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libsbml:5.20.4--hd2ed0a0_1
stdout: libsbml.out
