cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanook
label: nanook
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space while attempting to pull the NanoOK image.\n
  \nTool homepage: https://github.com/xhubio/nanook-table"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/nanook:v1.33dfsg-1-deb_cv1
stdout: nanook.out
