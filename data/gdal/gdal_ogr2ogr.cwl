cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogr2ogr
label: gdal_ogr2ogr
doc: "Converts simple features data between file formats.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_ogr2ogr.out
