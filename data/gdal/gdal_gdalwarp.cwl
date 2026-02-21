cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalwarp
label: gdal_gdalwarp
doc: "\nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_gdalwarp.out
