cwlVersion: v1.2
class: CommandLineTool
baseCommand: dcmtk
label: dcmtk
doc: "The provided text does not contain help information for dcmtk; it contains error
  logs from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: http://dicom.offis.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dcmtk:v3.6.120160216-4-deb_cv1
stdout: dcmtk.out
