cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapgl_mapGL.py
label: mapgl_mapGL.py
doc: "The provided text does not contain help information for the tool, but rather
  error messages from a container runtime (Singularity/Apptainer) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/adadiehl/mapGL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapgl:1.3.1--pyh5ca1d4c_0
stdout: mapgl_mapGL.py.out
