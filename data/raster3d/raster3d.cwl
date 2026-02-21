cwlVersion: v1.2
class: CommandLineTool
baseCommand: raster3d
label: raster3d
doc: "Raster3D is a set of programs for photorealistic rendering of molecular models.
  (Note: The provided text is a container build error log and does not contain CLI
  help information or argument definitions).\n\nTool homepage: https://github.com/Sundance636/Raster3D"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/raster3d:v3.0-3-5-deb_cv1
stdout: raster3d.out
