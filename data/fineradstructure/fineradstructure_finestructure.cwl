cwlVersion: v1.2
class: CommandLineTool
baseCommand: fineradstructure
label: fineradstructure_finestructure
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to lack of disk space.\n\nTool homepage: http://cichlid.gurdon.cam.ac.uk/fineRADstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
stdout: fineradstructure_finestructure.out
