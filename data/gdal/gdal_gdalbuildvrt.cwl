cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalbuildvrt
label: gdal_gdalbuildvrt
doc: "The provided text does not contain help information for gdalbuildvrt. It appears
  to be a system error log indicating a failure to pull or build the container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_gdalbuildvrt.out
