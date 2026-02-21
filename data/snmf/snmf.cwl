cwlVersion: v1.2
class: CommandLineTool
baseCommand: snmf
label: snmf
doc: "The provided text does not contain help information for the tool 'snmf'. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the container image.\n\nTool homepage: http://membres-timc.imag.fr/Olivier.Francois/snmf/index.htm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snmf:1.2--1
stdout: snmf.out
