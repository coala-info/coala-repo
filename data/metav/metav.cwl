cwlVersion: v1.2
class: CommandLineTool
baseCommand: metav
label: metav
doc: "The provided text does not contain help information or usage instructions. It
  consists of container runtime error logs indicating a failure to build or run the
  SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/ZhijianZhou01/metav"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metav:2.0.0--pyhdfd78af_0
stdout: metav.out
