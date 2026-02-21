cwlVersion: v1.2
class: CommandLineTool
baseCommand: raster3d_Engine
label: raster3d_Engine
doc: "The Raster3D molecular graphics package is a set of programs for generating
  high quality photorealistic images of proteins and other molecules. (Note: The provided
  text is a container build log and does not contain command-line help information.)\n
  \nTool homepage: https://github.com/Sundance636/Raster3D"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/raster3d:v3.0-3-5-deb_cv1
stdout: raster3d_Engine.out
