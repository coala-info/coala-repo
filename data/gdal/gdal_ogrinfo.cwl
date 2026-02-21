cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdal_ogrinfo
label: gdal_ogrinfo
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failure due
  to insufficient disk space.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_ogrinfo.out
