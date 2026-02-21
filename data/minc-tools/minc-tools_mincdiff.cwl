cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincdiff
label: minc-tools_mincdiff
doc: "Compare two MINC files. (Note: The provided help text contains system error
  messages regarding container execution and does not list command-line arguments.)\n
  \nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincdiff.out
