cwlVersion: v1.2
class: CommandLineTool
baseCommand: worldtovoxel
label: minc-tools_worldtovoxel
doc: "The provided text is an error log from a container runtime and does not contain
  the help documentation for the tool. worldtovoxel is a MINC tool used to convert
  world coordinates to voxel coordinates.\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_worldtovoxel.out
