cwlVersion: v1.2
class: CommandLineTool
baseCommand: imagevis3d
label: imagevis3d
doc: "ImageVis3D is a desktop application for interactive visualization of large volumetric
  data sets.\n\nTool homepage: https://github.com/SCIInstitute/ImageVis3D"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/imagevis3d:v3.1.0-5-deb_cv1
stdout: imagevis3d.out
