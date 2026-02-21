cwlVersion: v1.2
class: CommandLineTool
baseCommand: dicom3tools
label: dicom3tools
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Apptainer/Singularity)
  failing to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/malaterre/dicom3tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dicom3tools:v1.0020180803063840-1-deb_cv1
stdout: dicom3tools.out
