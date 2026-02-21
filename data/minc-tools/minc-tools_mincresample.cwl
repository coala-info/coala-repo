cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincresample
label: minc-tools_mincresample
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincresample.out
