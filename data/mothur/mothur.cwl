cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur
doc: "The provided text does not contain help information for the tool. It consists
  of error messages related to a container runtime (Apptainer/Singularity) failing
  to build the mothur image due to insufficient disk space.\n\nTool homepage: https://www.mothur.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur.out
