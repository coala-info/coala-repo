cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdal_translate
label: gdal_gdal_translate
doc: "The provided text does not contain help information for gdal_translate; it is
  an error log indicating a failure to pull the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_gdal_translate.out
