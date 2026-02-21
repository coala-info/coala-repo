cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtk-dicom-tools
label: vtk-dicom-tools
doc: "The provided text is a container engine error log (Singularity/Apptainer) and
  does not contain the help text or usage information for the tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/LinkunGao/copper3d_visualisation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/vtk-dicom-tools:v0.8.9-1-deb_cv1
stdout: vtk-dicom-tools.out
