cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincinfo
label: minc-tools_mincinfo
doc: "Get information on MINC files (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincinfo.out
