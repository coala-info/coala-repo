cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincedit
label: minc-tools_mincedit
doc: "A tool from the minc-tools suite. (Note: The provided help text contains system
  error messages and does not list usage or arguments.)\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools_mincedit.out
