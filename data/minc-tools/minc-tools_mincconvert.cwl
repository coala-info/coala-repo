cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincconvert
label: minc-tools_mincconvert
doc: "The provided text does not contain help information for mincconvert, but rather
  an error message regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincconvert.out
