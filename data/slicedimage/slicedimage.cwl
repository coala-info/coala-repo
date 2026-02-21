cwlVersion: v1.2
class: CommandLineTool
baseCommand: slicedimage
label: slicedimage
doc: "The provided text does not contain a description or usage information for the
  tool 'slicedimage'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://github.com/spacetx/slicedimage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slicedimage:3.1.2--py_0
stdout: slicedimage.out
