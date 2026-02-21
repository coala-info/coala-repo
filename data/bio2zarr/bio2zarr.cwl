cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio2zarr
label: bio2zarr
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log related to a container build failure (no space left on
  device).\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
stdout: bio2zarr.out
