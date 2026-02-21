cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtkgdcm
label: vtkgdcm
doc: 'A tool related to the Grassroots DICOM (GDCM) library and the Visualization
  Toolkit (VTK). Note: The provided text contains container build logs and does not
  list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/vtkgdcm:v2.8.8-9-deb-py3_cv1
stdout: vtkgdcm.out
