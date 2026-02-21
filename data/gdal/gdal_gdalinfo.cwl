cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalinfo
label: gdal_gdalinfo
doc: "The provided text does not contain help information for gdalinfo; it contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_gdalinfo.out
