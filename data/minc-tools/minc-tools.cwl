cwlVersion: v1.2
class: CommandLineTool
baseCommand: minc-tools
label: minc-tools
doc: "A suite of tools for processing MINC format medical imaging data. Note: The
  provided text contains system error messages regarding container image creation
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/BIC-MNI/minc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
stdout: minc-tools.out
