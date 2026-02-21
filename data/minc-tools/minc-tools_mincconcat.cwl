cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincconcat
label: minc-tools_mincconcat
doc: "Concatenate MINC files along a specific dimension (Note: The provided text contains
  system error messages and does not include the actual help documentation for this
  tool).\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincconcat.out
