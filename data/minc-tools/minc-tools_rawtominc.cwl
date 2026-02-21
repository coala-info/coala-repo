cwlVersion: v1.2
class: CommandLineTool
baseCommand: rawtominc
label: minc-tools_rawtominc
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error message indicating a failure to pull or build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_rawtominc.out
