cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdal
label: gdal
doc: "The provided text does not contain help information for GDAL; it is an error
  log indicating a failure to build or run a container due to insufficient disk space.\n
  \nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal.out
