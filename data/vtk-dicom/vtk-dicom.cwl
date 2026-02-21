cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtk-dicom
label: vtk-dicom
doc: "The provided text does not contain help information or usage instructions for
  vtk-dicom; it contains error logs from a container runtime (Apptainer/Singularity)
  failing to fetch the image.\n\nTool homepage: https://github.com/jiafeng5513/QvtkDicomReader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/vtk-dicom:v0.8.9-1-deb-py3_cv1
stdout: vtk-dicom.out
